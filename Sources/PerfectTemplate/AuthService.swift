//
//  AuthService.swift
//  PerfectTemplate
//
//  Created by Andrey Yusupov on 27/01/2019.
//

import Foundation
import PerfectHTTP

protocol AuthService {
	
	var login: (HTTPRequest, HTTPResponse) -> () { get }
	
	var logout: (HTTPRequest, HTTPResponse) -> () { get }
	
	var changeUserData: (HTTPRequest, HTTPResponse) -> () { get }
	
	var registerUser: (HTTPRequest, HTTPResponse) -> () { get }
}

class AuthServiceImpl: AuthService {
	
	let login: (HTTPRequest, HTTPResponse) -> () = { request, response in
		guard (request.param(name: "username") != nil)
			&& (request.param(name: "password") != nil)
			else {
				let errorMessage: [String: Any] = ["result": 0,
												   "errorMessage": "error"]
				try? response
					.setBody(json: errorMessage)
					.completed(status: HTTPResponseStatus.custom(
						code: 401,
						message: "error"))
				return
		}
		let successMessage: [String: Any] = [
			"result": 1,
			"user": ["id_user": 1,
					 "user_login": "UserLogin",
					 "user_name": "UserName",
					 "user_lastname": "UserLastname"]]
		try? response
			.setBody(json: successMessage)
			.completed(status: HTTPResponseStatus.statusFrom(code: 200))
	}
	
	let logout: (HTTPRequest, HTTPResponse) -> () = { request, response in
		guard (request.param(name: "id_user") != nil)
			else {
				let errorMessage: [String: Any] = ["result": 0,
												   "errorMessage": "error"]
				try? response
					.setBody(json: errorMessage)
					.completed(status: HTTPResponseStatus.custom(
						code: 401,
						message: "error"))
				return
		}
		try? response
			.setBody(json: ["result": 1])
			.completed(status: HTTPResponseStatus.statusFrom(code: 200))
	}
	
	let changeUserData: (HTTPRequest, HTTPResponse) -> () = { request, response in
		let params = request.postParams
		let user = User(params)
		guard user.isUser()
			else {
				let errorMessage: [String: Any] = ["result": 0,
												   "errorMessage": "error"]
				try? response
					.setBody(json: errorMessage)
					.completed(status: HTTPResponseStatus.custom(
						code: 401,
						message: "error"))
				return
		}
		try? response
			.setBody(json: ["result": 1])
			.completed(status: HTTPResponseStatus.statusFrom(code: 200))
	}
	
	let registerUser: (HTTPRequest, HTTPResponse) -> () = { request, response in
		let params = request.postParams
		let user = User(params)
		guard user.isUser()
			else {
				let errorMessage: [String: Any] = ["result": 0,
												   "errorMessage": "error"]
				try? response
					.setBody(json: errorMessage)
					.completed(status: HTTPResponseStatus.custom(
						code: 401,
						message: "error"))
				return
		}
		let successMessage: [String: Any] = [
			"result": 1,
			"userMessage": "Регистрация прошла успешно!"
		]
		try? response
			.setBody(json: successMessage)
			.completed(status: HTTPResponseStatus.statusFrom(code: 200))
	}
}
