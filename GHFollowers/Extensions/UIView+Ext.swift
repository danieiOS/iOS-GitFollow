//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/2/24.
//

import UIKit

extension UIView {
	/// ScrollView AutoLayout 설정을 extension으로 구현 iPhone SE 대응
	func pinToEdges(of superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor),
		])
	}
	
	//여러 개의 서브뷰를 설정하게 만들어 주는 커스텀 메소드
	func addSubviews(_ views: UIView...) {
		for view in views { addSubview(view) }
	}
}
