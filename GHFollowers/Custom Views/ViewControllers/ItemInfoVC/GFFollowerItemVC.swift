
import Foundation

protocol GFFollowerItemVCDelegae: AnyObject {
	func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
	
	weak var delegate: GFFollowerItemVCDelegae!
	
	init(user: User, delegate: GFFollowerItemVCDelegae) {
		super.init(user: user)
		self.delegate = delegate
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItems()
	}
	
	private func configureItems() {
		itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
		itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
		actionButton.set(backgroundColor: .systemMint, title: "Get Followers")
	}
	
	override func actionButtonTapped() {
		delegate.didTapGetFollowers(for: user)
	}
}
