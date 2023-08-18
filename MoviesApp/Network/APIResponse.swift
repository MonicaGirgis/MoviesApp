//
//  APIResponse.swift
//  SimpleNews
//
//  Created by Monica Girgis Kamel on 08/01/2022.
//

import Foundation

struct APIResponse<R: Codable>: Codable {
    var page: Int?
    var results: R
    var total_pages: Int?
    var total_results: Int?
}

struct httpHeader:Decodable {
    var key:String
    var value:String
}

struct GeneralErrorMessage: Decodable{
    var status: String?
    var code: String?
    var message: String?
}
