//
//  GFAlertContainerView.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/2/24.
//

import UIKit

// AlertViewContoller에서 containerView 디자인 파일 분리
class GFAlertContainerView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		backgroundColor = .systemBackground
		layer.cornerRadius = 16
		layer.borderWidth = 2
		layer.borderColor = UIColor.white.cgColor
		translatesAutoresizingMaskIntoConstraints = false
	}

}
