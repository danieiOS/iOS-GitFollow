//
//  GFButton.swift
//  GHFollowers
//
//  Created by 송성욱 on 3/28/24.
//

import UIKit

class GFButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(corder:) has not been implemented")
	}
	
	/// 버튼의 커스터마이징을 위한 초기화
	convenience init(backgroundColor: UIColor, title: String) {
		self.init(frame: .zero)
		self.backgroundColor = backgroundColor
		self.setTitle(title, for: .normal)
	}
	
	private func configure() {
		layer.cornerRadius = 10
		setTitleColor(.white, for: .normal)
		titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		translatesAutoresizingMaskIntoConstraints = false // Autolayout coustom constraint setting
	}
	
	func set(backgroundColor: UIColor, title: String) {
		self.backgroundColor = backgroundColor
		setTitle(title, for: .normal)
	}
}
