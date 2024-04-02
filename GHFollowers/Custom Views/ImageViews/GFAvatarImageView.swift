//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by 송성욱 on 3/29/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
	
	let cache = NetworkManager.shared.cache
	let placeholderImage = Images.placeholder
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// design
	private func configure() {
		layer.cornerRadius = 10
		clipsToBounds = true
		image = placeholderImage
		translatesAutoresizingMaskIntoConstraints = false
	}

}
