//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/2/24.
//

import UIKit

extension UITableView {
	
	func reloadDataOnMainThread() {
		DispatchQueue.main.async { self.reloadData() }
	}
	
	func removeExcessCells() {
		tableFooterView = UIView(frame: .zero)
	}
}
