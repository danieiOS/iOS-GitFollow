//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/1/24.
//

import Foundation
/// Date타입을 String 타입으로 변환
extension Date {
	func convertToMonthYearFormat() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM yyyy"
		return dateFormatter.string(from: self)
	}
}
