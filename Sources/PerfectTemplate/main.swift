//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer

let authService = AuthServiceImpl()
let reviewService = ReviewServiceImpl()
let productService = ProductServiceImpl()
let basketService = BasketServiceImpl()

var routes = Routes()
routes.add(method: .post, uri: "/login", handler: authService.login)
routes.add(method: .get, uri: "/logout", handler: authService.logout)
routes.add(method: .post, uri: "/changeUserData", handler: authService.changeUserData)
routes.add(method: .post, uri: "/registerUser", handler: authService.registerUser)

routes.add(method: .post, uri: "/addReview", handler: reviewService.addReview)
routes.add(method: .get, uri: "/removeReview", handler: reviewService.removeReview)
routes.add(method: .get, uri: "/reviewList", handler: reviewService.reviewList)

routes.add(method: .get, uri: "/catalogData", handler: productService.catalogData)
routes.add(method: .get, uri: "/getProduct", handler: productService.getProduct)

routes.add(method: .get, uri: "/addProduct", handler: basketService.addProduct)
routes.add(method: .get, uri: "/removeProduct", handler: basketService.removeProduct)
routes.add(method: .get, uri: "/pay", handler: basketService.pay)

try HTTPServer.launch(name: "localhost",
					  port: 8181,
					  routes: routes,
					  responseFilters: [
						(PerfectHTTPServer.HTTPFilter.contentCompression(data: [:]), HTTPFilterPriority.high)])

