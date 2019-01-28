//
//  ProductService.swift
//  PerfectTemplate
//
//  Created by Andrey Yusupov on 28/01/2019.
//

import Foundation
import PerfectHTTP

protocol ProductService {
	
	var catalogData: (HTTPRequest, HTTPResponse) -> () { get }
}

class ProductServiceImpl: ProductService {
	
	let catalogData: (HTTPRequest, HTTPResponse) -> () = { request, response in
		guard let pageNumberStr = request.param(name: "page_number"),
			let categoryIdStr = request.param(name: "id_category"),
			let categoryId = Int(categoryIdStr),
			let pageNumber = Int(pageNumberStr)
			
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
			"response": [
				"page_number": pageNumber,
				"id_category": categoryId,
				"products": [
					["id_product": 123,
					 "product_name": "Ноутбук",
					 "price": 65000,
					 "discription": ""],
					["id_product": 2,
					 "product_name": "Ноутбук",
					 "price": 1999.9,
					 "discription": "Имеются повреждения"]
				]
			]
		]
		
		try? response
			.setBody(json: successMessage)
			.completed(status: HTTPResponseStatus.statusFrom(code: 200))
	}
}
