//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/1/24.
//

import UIKit

protocol ItemInfoVCDelegate: AnyObject {
	func didTabGitHubProfile(for user: User)
	func didTabGetFollowers(for user: User)
}

class GFItemInfoVC: UIViewController {
	
	let stackView = UIStackView()
	let itemInfoViewOne = GFItemInfoView()
	let itemInfoViewTwo = GFItemInfoView()
	let actionButton = GFButton()
	
	var user: User!
	
	init(user: User) {
		super.init(nibName: nil, bundle: nil)
		self.user = user
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureBackgroundView()
		configureActionButton()
		layoutUI()
		configureStackView()
	}
	
	private func configureBackgroundView() {
		view.layer.cornerRadius = 18
		view.backgroundColor = .secondarySystemBackground
		
	}
	
	private func configureStackView() {
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		//MARK: - ✅
		// addArrangeSubview(_:) 는 자동으로 뷰의 레이아웃을 관리하게 됩니다.
		///새로운 하위 뷰가 추가될 때마다 수동으로 크기와 위치를 수정할 필요가 없습니다. => 코드를 간결하게 유지하고 유연성을 높임
		stackView.addArrangedSubview(itemInfoViewOne)
		stackView.addArrangedSubview(itemInfoViewTwo)
	}
	
	private func configureActionButton() {
		actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
	}
	
	@objc func actionButtonTapped() {}
	
	private func layoutUI() {
		view.addSubviews(stackView, actionButton)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		let padding: CGFloat = 20
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			stackView.heightAnchor.constraint(equalToConstant: 50),
			
			actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
			actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 50),
			
		])
	}
	
}
