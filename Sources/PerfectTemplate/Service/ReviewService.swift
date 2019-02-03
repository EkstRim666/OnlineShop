//
//  Кумшуц.swift
//  PerfectTemplate
//
//  Created by Andrey Yusupov on 28/01/2019.
//

import Foundation
import PerfectHTTP

protocol ReviewService {
	
	var addReview: (HTTPRequest, HTTPResponse) -> () { get }
	
	var removeReview: (HTTPRequest, HTTPResponse) -> () { get }
	
	var reviewList: (HTTPRequest, HTTPResponse) -> () { get }
}

class ReviewServiceImpl: ReviewService {
	
	let addReview: (HTTPRequest, HTTPResponse) -> () = { request, response in
		guard (request.param(name: "id_user") != nil)
			&& (request.param(name: "text") != nil)
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
			"userMessage": "Ваш отзыв передан на модерацию"
		]
		try? response
			.setBody(json: successMessage)
			.completed(status: HTTPResponseStatus.statusFrom(code: 200))
	}
	
	let removeReview: (HTTPRequest, HTTPResponse) -> () = { request, response in
		guard request.param(name: "id_review") != nil else {
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
	
	let reviewList: (HTTPRequest, HTTPResponse) -> () = { request, response in
		guard request.param(name: "id_product") != nil else {
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
			"reviews": [
				["id_review": 1,
				 "id_user": 1,
				 "text": "Тело сообщения"],
				["id_review": 2,
				 "id_user": 5,
				 "text": "Тело"],
			]
		]
		try? response
			.setBody(json: successMessage)
			.completed(status: HTTPResponseStatus.statusFrom(code: 200))
	}
}
