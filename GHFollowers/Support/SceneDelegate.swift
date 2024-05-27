//
//  SceneDelegate.swift
//  GHFollowers
//
//  Created by 송성욱 on 3/28/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		/// UINavigationController -> SwiftUI 에서 NavigationStack이랑 같은 기능
		//let searchNC = UINavigationController(rootViewController: SearchViewController())
		//let favoritesNC = UINavigationController(rootViewController: FavoritesListViewController())
		
		/// TabBarController 인스턴스를 만들어서 두개의 ViewController들을 연결 시켜주면 된다.
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = GFTabBarController()
		window?.makeKeyAndVisible()
		
		configureNavigationBar()
	}
	/// SceneDelegate에 선언
	/// appearance => 네비게이션 바 요소들의 설정을  바꿔준다.
	func configureNavigationBar() {
		UINavigationBar.appearance().tintColor = .systemGreen
	}
	
	func sceneDidDisconnect(_ scene: UIScene) {
	
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		
	}

	func sceneWillResignActive(_ scene: UIScene) {
	
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
	
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
	
	}
}

