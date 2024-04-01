//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/1/24.
//

import Foundation

extension Date {
	func convertToMonthYearFormat() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM yyyy"
		return dateFormatter.string(from: self)
	}
}
