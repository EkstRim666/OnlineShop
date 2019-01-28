//
//  User.swift
//  PerfectTemplate
//
//  Created by Andrey Yusupov on 27/01/2019.
//

import Foundation

struct User {
	let id: Int
	let userName: String
	let password: String
	let email: String
	let gender: String
	let creditCard: String
	let bio: String
	
	private struct EmptyUser {
		var id = 0
		var userName = ""
		var password = ""
		var email = ""
		var gender = ""
		var creditCard = ""
		var bio = ""
	}
	
	init(_ array: [(String, String)]) {
		var emptyUser = EmptyUser()
		
		for (key, value) in array {
			switch key {
			case "id_user":
				emptyUser.id = Int(value) ?? 0
				break
			case "username":
				emptyUser.userName = value
				break
			case "password":
				emptyUser.password = value
				break
			case "email":
				emptyUser.email = value
				break
			case "gender":
				emptyUser.gender = value
				break
			case "credit_card":
				emptyUser.creditCard = value
				break
			case "bio":
				emptyUser.bio = value
				break
			default:
				continue
			}
		}
		
		self.id = emptyUser.id
		self.userName = emptyUser.userName
		self.password = emptyUser.password
		self.email = emptyUser.email
		self.gender = emptyUser.gender
		self.creditCard = emptyUser.creditCard
		self.bio = emptyUser.bio
	}
	
	func isUser() -> Bool {
		let emptyUser = EmptyUser()
		if (self.id == emptyUser.id)
			|| (self.userName == emptyUser.userName)
			|| (self.password == emptyUser.password)
			|| (self.email == emptyUser.email)
			|| (self.gender == emptyUser.gender)
			|| (self.creditCard == emptyUser.creditCard)
			|| (self.bio == emptyUser.bio)
		{
			return false
		} else {
			return true
		}
	}
}
