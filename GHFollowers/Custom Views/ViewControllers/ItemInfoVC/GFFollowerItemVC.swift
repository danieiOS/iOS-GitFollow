//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/1/24.
//

import Foundation

class GFFollowerItemVC: GFItemInfoVC {
	
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
		delegate.didTabGetFollowers(for: user)
	}
}
