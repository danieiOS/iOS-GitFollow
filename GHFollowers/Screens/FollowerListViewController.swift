import UIKit

protocol FollowerListVCDelegate: AnyObject {
	func didRequestFollowers(for username: String)
}

class FollowerListViewController: UIViewController {
	
	enum Section { case main }
	
	var username: String!
	var followers: [Follower] = []
	var filteredFollowers: [Follower] = []
	var page = 1
	var hasMoreFollowers = true
	var isSearching = false
	
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		configureSearchController()
		configureCollectionView()
		collectionView.delegate = self
		getFollowers(username: username, page: page)
		configureDataSource()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(false, animated: true)
		// navigationController?.isNavigationBarHidden = false
		// 타이틀과 네비게이션 바 부분이 화면이동 속도보다 더 빨리 나타난다.
		// 이동 속도를 바꿔주기 위해서 viewDidLoad에 선언했던 걸 viewWillAppear 부분에 선언해준다.
		// SearchViewController 부분도 바꿔준다 setNavigationBarHidden으로..
	}
	
	func configureViewController() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true //Inline title(default)에서 large title로 변경
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
		navigationItem.rightBarButtonItem = addButton
	}
	
	func configureCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
		view.addSubview(collectionView)
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}
	// search functionally
	func configureSearchController() {
		let searchController = UISearchController()
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.searchBar.placeholder = "Search for a username"
		navigationItem.searchController = searchController
	}
	
	/// weak self 순환참조에서 메모리 누수를 막기 위해서 사용
	func getFollowers(username: String, page: Int) {
		//로딩뷰 보여주기
		showLoadingView()
		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
			guard let self = self else { return }
			//로딩뷰 취소
			self.dismissLoadingView()
			
			switch result {
			case .success(let followers):
				if followers.count < 100 { self.hasMoreFollowers = false }
				self.followers.append(contentsOf: followers)
				
				if self.followers.isEmpty {
					let message = "This user doesn't have any followers. Go follow them."
					DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
					return
				}
				
				self.updateData(on: self.followers)
				
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	
	// 컬렉션뷰에 셀을 재사용하기 위해서는 데이터 UICollectionViewDiffableDataSource 를 이용해서 셀을 만들어 줘야 한다.
	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
			cell.set(follower: follower)
			return cell
		})
	}
	
	// 데이터를 snapshot에 추가해준다.
	func updateData(on followers: [Follower]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
	}
	
	@objc func addButtonTapped() {
		showLoadingView()
		//로컬에 내가 좋아하는 사람을 추가하기 위해서 UserDefaults를 사용
		NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
			guard let self = self else { return }
			self.dismissLoadingView()
			
			switch result {
			case .success(let user):
				let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
				
				PersistenceManager.update(favorite: favorite, actionType: .add) { [weak self] error in
					guard let self = self else { return }
					
					guard let error = error else {
						self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favorited this user!", buttonTitle: "Hooray!")
						return
					}
					
					self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
				}
				
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
}

// pagination
extension FollowerListViewController: UICollectionViewDelegate {
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height
		
		// 이 조건에서 데이터를 불러오는 원리
		if offsetY > contentHeight - height {
			guard hasMoreFollowers else { return }
			page += 1
			getFollowers(username: username, page: page)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let activeArray = isSearching ? filteredFollowers : followers
		let follower = activeArray[indexPath.item]
		
		let destVC = UserInfoViewController()
		destVC.username = follower.login
		destVC.delegate = self
		let navController = UINavigationController(rootViewController: destVC)
		present(navController, animated: true)
	}
}

//UISearchResultsUpdating => search 데이터를 결과값으로 보내주기위한 프로토콜
extension FollowerListViewController: UISearchResultsUpdating, UISearchBarDelegate {
	func updateSearchResults(for searchController: UISearchController) {
		guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
		isSearching = true
		///followers 배열에서 로그인 이름에 주어진 filter 문자열이 포함된 요소들만 남기고 나머지는 제거합니다. 결과적으로 이 코드는 검색 필터가 적용된 팔로워 목록을 반환합니다.
		filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
		updateData(on: filteredFollowers)
	}
	
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		isSearching = false
		// 원래 팔로워 업데이트
		updateData(on: followers)
	}
}


extension FollowerListViewController: FollowerListVCDelegate {
	func didRequestFollowers(for username: String) {
		self.username = username
		title = username
		page = 1
		followers.removeAll()
		filteredFollowers.removeAll()
		collectionView.setContentOffset(.zero, animated: true)
		getFollowers(username: username, page: page)
	}
}

// protocol & delegate One to One
// Notifications & Observers One to Many
