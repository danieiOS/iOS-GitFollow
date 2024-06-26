//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/1/24.
//

import UIKit
import SwiftUI

class GFEmptyStateView: UIView {
	
	let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
	let logoImageView = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureMessageLabel()
		configureLogoItemImageView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(message: String) {
		self.init(frame: .zero)
		messageLabel.text = message
	}
	
	private func configure() {
		addSubviews(messageLabel, logoImageView)
	}
	
	private func configureMessageLabel() {
		
		messageLabel.numberOfLines = 3
		messageLabel.textColor = .secondaryLabel
		
		let labelCenterYConstraint: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -115 //디바이스 대응
		
		NSLayoutConstraint.activate([
			messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstraint),
			messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
			messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
			messageLabel.heightAnchor.constraint(equalToConstant: 200),
		])
	}
	
	private func configureLogoItemImageView() {
		
		logoImageView.image = Images.emptyStateLogo
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		
		let logoBottomConstraint: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 50 //디바이스 대응
		
		NSLayoutConstraint.activate([
			logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
			logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstraint),
		])
	}
}


