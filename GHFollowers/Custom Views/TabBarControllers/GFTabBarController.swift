//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/2/24.
//

import UIKit

//#Refactoring => TabBarController 분리시키기
class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
			///appearance 탭바 부분 디자인을 변경시키기 위한 메서드
			UITabBar.appearance().tintColor = .systemGreen
			viewControllers = [createSearchNC(), createFavoritesNC()]
    }
	
	// 탭에 NavigationController 연결
	func createSearchNC() -> UINavigationController {
		let searchVC = SearchViewController()
		searchVC.title = "Search"
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		return UINavigationController(rootViewController: searchVC)
	}
	
	//탭에 NavigationController 연결
	func createFavoritesNC() -> UINavigationController {
		let favoritesListVC = FavoritesListViewController()
		favoritesListVC.title = "Favorites"
		favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		return UINavigationController(rootViewController: favoritesListVC)
	}
}
