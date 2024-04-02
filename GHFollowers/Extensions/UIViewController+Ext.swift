//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by 송성욱 on 3/29/24.
//

import UIKit
import SafariServices

extension UIViewController {
	/// 커스텀 Alert기능 구현
	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			self.present(alertVC, animated: true)
		}
	}
	
	func presentSafariVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
		safariVC.preferredControlTintColor = .systemGreen
		present(safariVC, animated: true)
	}
}


//premature
//optimization
