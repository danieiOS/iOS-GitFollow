//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/1/24.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
	//1. super view의 frame을 초기화 시킵니다
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	//2. NSCoder를 사용하여 객체를 디코딩하고 초기화하는 데 사용됩니다. 일반적으로 이 메서드는 인터페이스 빌더에서 생성된 객체를 인스턴스화할 때 호출됩니다.
	required init?(coder: NSCoder) {
		/// ini(coder:)t 메서드가 호출되지 않으면 오류를 발생시키는 메세지를 생성
		fatalError("init(coder:) has not been implemented")
	}
	
	//3. size를 customize하게 설정하기 위한 초기화 코드
	convenience init(fontSize: CGFloat) {
		self.init(frame: .zero)
		font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
	}
	
	private func configure() {
		textColor = .secondaryLabel
		///adjustsFontSizeToFitWidth는 UILabel 클래스의 속성으로, 레이블에 표시되는 텍스트의 크기를 자동으로 조절하여 해당 텍스트가 레이블의 너비에 맞도록 하는 데 사용됩니다.
		///이 속성을 사용하면 긴 텍스트를 표시할 때 텍스트의 크기를 자동으로 조절하여 텍스트가 레이블의 너비에 맞게 됩니다.
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.90
		lineBreakMode = .byTruncatingTail
		translatesAutoresizingMaskIntoConstraints = false
	}
}
