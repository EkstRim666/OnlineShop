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
}
