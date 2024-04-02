//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by 송성욱 on 3/28/24.
//

import UIKit

class SearchViewController: GFDataLoadingVC {
	let logoImageView = UIImageView()
	let usernameTextField = GFTextField()
	let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
	//디바이스 대응
	var logoImageViewTopConstraint: NSLayoutConstraint!
	
	var isUsernameEntereed: Bool { return !usernameTextField.text!.isEmpty } //연산 프로퍼티로 선언, usernameTextField에 비어있지 않으면 true를 반환
	/// View의 Controller가 메모리에 로드된 뒤 호출 (앱 실행 시 한번 호출)
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureLogoImageView()
		configureTextField()
		configureCallToActionButton()
		createDismissKeyboardTabGesture()
	}
	
	/// View가 표기되기 직전 호출 (viewDidAppear ==> View가 표기되기 직후 호출) (화면에 진입할 때마다 호출)
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		///빈 문자열로 초기화
		usernameTextField.text = ""
		navigationController?.setNavigationBarHidden(true, animated: true)
				//navigationController?.isNavigationBarHidden = true
		
	}
	
	func createDismissKeyboardTabGesture() {
		/// UIGestureRecognizer : 터치(또는 기타 입력)를 인식하고 해당 인식에 따라 작동하는 논리를 분리 [제스처 개체 -> 제스처의 변화를 인식하면 지정된 대상 개체에 작업 메세지를 보냅니다
		let tab = UIGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tab)
	}
	
	@objc func pushFollowerListVC() {
		guard isUsernameEntereed else {
			presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀", buttonTitle: "Ok")
			print("No username")
			return
		}
		// 텍스트가 필드에 값이 입력되고 키보드가 내려가게끔 만들어줍니다.
		usernameTextField.resignFirstResponder()
		
		///객에에 인자로 받아 올 수 있도록 FollowerListVC에서 매개변수 만들어 줌
		let followerListVC = FollowerListViewController(username: usernameTextField.text!)
		navigationController?.pushViewController(followerListVC, animated: true)
	}
	
	/// 함수로 따로 만들어서 가독성있고 수정이 편리하게 관리한다.
	func configureLogoImageView() {
		view.addSubview(logoImageView)
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.image = Images.ghLogo //Stringly type
		
		// 디바이스 대응 코드 적용
		let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
		
		logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
		logoImageViewTopConstraint.isActive = true
		
		// autolayout 제약조건을 한번에 작성 할 수 있다.
		NSLayoutConstraint.activate([
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: 200),
			logoImageView.widthAnchor.constraint(equalToConstant: 200),
		])
	}
	
	func configureTextField() {
		view.addSubview(usernameTextField)
		usernameTextField.delegate = self
		
		NSLayoutConstraint.activate([
			usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
			usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			usernameTextField.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	func configureCallToActionButton() {
		view.addSubview(callToActionButton)
		/// 버튼에 액션을 추가해주는 메소드 addTarget(_:action:for:)
		callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
			callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			callToActionButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}

// passing data
extension SearchViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		pushFollowerListVC()
		return true
	}
}
