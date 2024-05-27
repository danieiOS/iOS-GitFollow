//
//  PreviewSup.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/5/24.
//

import SwiftUI

struct VCPreview<T: UIViewController>: UIViewControllerRepresentable {
	let viewController: T
	
	
	init(_ viewControllerBuilder: @escaping () -> T) {
		viewController = viewControllerBuilder()
	}
	
	func makeUIViewController(context: Context) -> T {
		return viewController
	}
	
	func updateUIViewController(_ uiViewController: T, context: Context) { }
}
