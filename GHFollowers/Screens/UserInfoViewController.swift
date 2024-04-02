//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/1/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
	func didRequestFollowers(for username: String)
}

class UserInfoViewController: GFDataLoadingVC {
	let headerView = UIView()
	let itemViewOne = UIView()
	let itemViewTwo = UIView()
	let dateLabel = GFBodyLabel(textAlignment: .center)
	var itemViews: [UIView] = []
	
	var username: String!
	
	weak var delegate: UserInfoVCDelegate!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		layoutUI()
		getUserInfo()
	}
	
	func configureViewController() {
		view.backgroundColor = .systemBackground
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
		navigationItem.rightBarButtonItem = doneButton
	}
	
	func getUserInfo() {
		NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let user):
				// main thread 우선적 점유
				DispatchQueue.main.async { self.configureUIElements(with: user) }
				print(user)
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
			}
		}
	}
	
	func configureUIElements(with user: User) {
		//let repoItemVC = GFRepoItemVC(user: user)
		//repoItemVC.delegate = self
		
		//let followerItemVC = GFFollowerItemVC(user: user)
		//followerItemVC.delegate = self
		
		// 추가 할 뷰에 프로토콜과 delegate를 만들어 놓으면 위에 코드 처럼 인스턴스를 생성하지 않아도 됌
		// 따로 인스턴스를 생성하지 않고 바로 추가할 수 있도록 각 item vc 에 프로토콜을 생성하고 delegate를 초기화해 연결 할 수 있도록 구현
		self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
		self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
		self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
	}
	
	func layoutUI() {
		itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
		
		let padding: CGFloat = 20
		let itemHeight: CGFloat = 140
		
		for itemView in itemViews {
			view.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			
			NSLayoutConstraint.activate([
				itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
				itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			])
		}
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			headerView.heightAnchor.constraint(equalToConstant: 180),
			
			itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
			itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
			
			itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
			itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
			
			dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
			dateLabel.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	func add(childVC: UIViewController, to containerView: UIView) {
		addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
	}
	
	@objc func dismissVC() {
		dismiss(animated: true)
	}
}

extension UserInfoViewController: GFRepoItemVCDelegate {
	
	func didTabGitHubProfile(for user: User) {
		guard let url = URL(string: user.htmlUrl) else {
			presentGFAlertOnMainThread(title: "Invalid", message: "The url attached to this user is invalid", buttonTitle: "OK")
			return
		}
		
		presentSafariVC(with: url)
	}
}

extension UserInfoViewController: GFFollowerItemVCDelegae {
	
	func didTapGetFollowers(for user: User) {
		guard user.followers != 0 else {
			presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers. What a shame", buttonTitle: "So sad")
			return
		}
		delegate.didRequestFollowers(for: user.login)
		dismissVC()
	}
}



//Lifecycle Method
//Self contained
//Flexible context
