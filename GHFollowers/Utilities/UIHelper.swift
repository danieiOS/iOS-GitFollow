
import UIKit

/// struct  타입 객체 생성할 시 사용할 때  빈 값으로 초기화를 시켜줘야 한다.  => let uiHelper = UIHelper()
/// enum 타입으로 객체 생성할 시 초기화 시키지 않고 바로 사용 할 수 있다. => UIHelper.createThreeColumnFlowLayout(in:)
enum UIHelper {
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
