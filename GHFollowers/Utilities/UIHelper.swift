//
//  UIHelper.swift
//  GHFollowers
//
//  Created by 송성욱 on 3/31/24.
//

import UIKit

struct UIHelper {
	//재사용 뷰를 만든다.
	static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
		let width = view.bounds.width
		let padding: CGFloat = 12
		let minimumItemSpacing: CGFloat = 10
		let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
		let itemWidth = availableWidth / 3
		
		/// 셀의 레이아웃을 구성
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
		return flowLayout
	}
}
