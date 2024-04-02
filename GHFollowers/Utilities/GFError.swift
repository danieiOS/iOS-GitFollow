//
//  GFError.swift
//  GHFollowers
//
//  Created by 송성욱 on 4/1/24.
//

import Foundation

enum GFError: String, Error {
	case InvalidUsername = "This username created an invalid request. Please try again"
	case unableToComplete = "Unable to complete your request. Please check your internet connection"
	case invalidResponse = "Invalid response from the server. please try again."
	case invalidData = "The data received from the server was invalid. Please try again."
	case unableToFavorite = "There was an error favoriting this user. Please try again."
	case alreadyInFavorites = "You`ve already favorited this user. You must REALLY like them!"
}