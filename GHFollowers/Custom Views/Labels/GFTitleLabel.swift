//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by 송성욱 on 3/29/24.
//

import UIKit

class GFTitleLabel: UILabel {

	///Designated initializer
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//커스텀 이니셜라이저 (=> 커스텀한 디자인을 적용시키고 싶을 때 사용하는 것 같다.)
	//conveniencce는 보조 initializer라고 생각하면 쉽다. Designated initializer를 도와주는 initializer이다.
	//(중복된 값 초기화 불가)
	convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat ) {
		self.init(frame: .zero)
		self.textAlignment = textAlignment
		self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
	}
	
	private func configure() {
		textColor = .label
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail // ...처리를 해준다
		translatesAutoresizingMaskIntoConstraints = false
	}
}
