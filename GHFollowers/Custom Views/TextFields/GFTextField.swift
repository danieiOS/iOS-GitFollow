//
//  GFTextField.swift
//  GHFollowers
//
//  Created by 송성욱 on 3/28/24.
//

import UIKit

class GFTextField: UITextField {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		
		layer.cornerRadius = 10
		layer.borderWidth = 2
		layer.borderColor = UIColor.systemGray4.cgColor // 레이어에 색을 주기 위해서는 cgColor
		
		textColor = .label
		tintColor = .label
		textAlignment = .center
		font = UIFont.preferredFont(forTextStyle: .title2)
		adjustsFontSizeToFitWidth = true // 텍스트 사이즈를 잘리지 않게 하는 방법 중 하나
		minimumFontSize = 12
		
		backgroundColor = .tertiarySystemBackground
		autocorrectionType = .no
		returnKeyType = .go
		/// 텍스트 삭제 기능
		clearButtonMode = .whileEditing
		placeholder = "Enter a username"
	}
}
