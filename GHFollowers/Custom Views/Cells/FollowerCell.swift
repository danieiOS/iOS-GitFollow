//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by 송성욱 on 3/29/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
	// downloading image
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(follower: Follower) {
		//이미지를 불러올 때 싱글톤으로 NetworkManager를 통해 받아올 수 있도록 구현
		avatarImageView.downloadImage(fromURL: follower.avatarUrl)
		usernameLabel.text = follower.login
		
	}
	
	private func configure() {
		
		addSubviews(avatarImageView, usernameLabel)
		
		let padding: CGFloat = 8
		
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
			
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
			usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			usernameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
}

///Initial setup
///FlowLayout
