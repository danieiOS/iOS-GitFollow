//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by 송성욱 on 3/29/24.
//

import UIKit

class GFBodyLabel: UILabel {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(textAlignment: NSTextAlignment) {
		self.init(frame: .zero)
		self.textAlignment = textAlignment
		configure()
	}
	
	private func configure() {
		textColor = .secondaryLabel
		font = UIFont.preferredFont(forTextStyle: .body)
		/// 글자크기 설정에 맞춰서 자동으로 변경 가능하게 만듬
		adjustsFontForContentSizeCategory = true
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.75
		lineBreakMode = .byWordWrapping
		translatesAutoresizingMaskIntoConstraints = false
	}
}
