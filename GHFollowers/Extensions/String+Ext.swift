//
//  String+Ext.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/1/24.
//

import Foundation
/// String type 날짜를 Date타입으로 변환한다 => 날짜 양식을 변경하기 위해서는 Date 타입에서 변경 후 다시 String으로 변환시켜줘야 한다.
extension String {
	func convertToDate() -> Date? {
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = .current
		return dateFormatter.date(from: self)
	}
	
	func convertToDisplayFormat() -> String {
		guard let date = self.convertToDate() else { return "N/A"}
		return date.convertToMonthYearFormat()
	}
}
