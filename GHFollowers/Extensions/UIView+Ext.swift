//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/2/24.
//

import UIKit

extension UIView {
	//여러 개의 서브뷰를 설정하게 만들어 주는 커스텀 메소드
	func addSubviews(_ views: UIView...) {
		for view in views { addSubview(view) }
	}
}
