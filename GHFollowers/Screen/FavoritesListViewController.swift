//
//  FavoritesListViewController.swift
//  GHFollowers
//
//  Created by 송성욱 on 3/28/24.
//

import UIKit

class FavoritesListViewController: GFDataLoadingVC {
	// tableView 인스턴스 생성
	let tableView = UITableView()
	var favorites: [Follower] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		configureTableView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getFavorites()
	}
	
	func configureViewController() {
		view.backgroundColor = .systemBackground
		title = "Favorites"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	//table view
	func configureTableView() {
		view.addSubview(tableView)
		tableView.frame = view.bounds
		tableView.rowHeight = 80
		//delegate
		tableView.delegate = self
		tableView.dataSource = self
		tableView.removeExcessCells()
		
		tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
	}
	
	func getFavorites() {
		PersistenceManager.retrieveFavorites { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let favorites):
				self.updateUI(with: favorites)
				
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	
	func updateUI(with favorites: [Follower]) {
		if favorites.isEmpty {
			showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen", in: self.view)
		} else {
			self.favorites = favorites
			DispatchQueue.main.async {
				self.tableView.reloadData()
				self.view.bringSubviewToFront(self.tableView)
			}
		}
	}
}

// table view Delegate & Datasource
extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate {
	/// 테이블의 갯수 설정
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favorites.count
	}
	
	// 셀을 재사용하도록 커스텀 셀을 설정하는 메소드
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
		let favorite = favorites[indexPath.row]
		cell.set(favorite: favorite)
		return cell
	}
	
	// 셀을 선택해서 목적지로 이동하는 메소드
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let favorite = favorites[indexPath.row]
		let destVC = FollowerListViewController(username: favorite.login)
		navigationController?.pushViewController(destVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		
		PersistenceManager.update(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
			guard let self = self else { return }
			guard let error = error else {
				self.favorites.remove(at: indexPath.row)
				tableView.deleteRows(at: [indexPath], with: .left)
				return
			}
			
			self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
		}
	}
}
