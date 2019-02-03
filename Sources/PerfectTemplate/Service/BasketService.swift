//
//  BasketService.swift
//  COpenSSL
//
//  Created by Andrey Yusupov on 03/02/2019.
//

import Foundation
import PerfectHTTP

protocol BasketService {
	
	var addProduct: (HTTPRequest, HTTPResponse) -> () { get }
	
	var removeProduct: (HTTPRequest, HTTPResponse) -> () { get }
	
	var pay: (HTTPRequest, HTTPResponse) -> () { get }
}

class BasketServiceImpl: BasketService {
	
	let addProduct: (HTTPRequest, HTTPResponse) -> () = {request, response in
		guard (request.param(name: "id_product") != nil)
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
	
	let removeProduct: (HTTPRequest, HTTPResponse) -> () = {request, response in
		guard (request.param(name: "id_product") != nil)
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
	
	let pay: (HTTPRequest, HTTPResponse) -> () = {request, response in
		guard (request.param(name: "id_basket") != nil)
			&& (request.param(name: "id_user") != nil)
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
}
