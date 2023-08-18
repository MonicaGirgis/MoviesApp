//
//  SimpleNews.swift
//  SimpleNews
//
//  Created by Monica Girgis Kamel on 06/01/2022.
//

import Foundation

enum Movies{
    case getData(page: Int)
    case getDetails(id: Int)
}

extension Movies: Endpoint{
    var base: String {
        return Bundle.main.baseURL
    }
    
    var urlSubFolder: String {
        return Bundle.main.urlSubFolder
    }
    
    var path: String {
        switch self {
        case .getData:
            return "popular"
            
        case .getDetails(let id):
            return "\(id)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "language", value: "en-US"))
        
        switch self{
        case .getData(let page):
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
            
        default:
           break
        }
        
        return queryItems
    }
    
    var headers : [httpHeader] {
        let httpHeaders = [
            httpHeader(key: "Authorization", value: "Bearer " +  "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZTA4OGEzZDdjNDdhYWQwN2NiMTgxYTUyZGI0MTMyNiIsInN1YiI6IjY0ZGYzMzEzNWFiODFhMDBhZDIwOGJlMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SpZaoS7AGKNyOsxgjs1uZA_kDp4IERNaHOuetxfYgG0"),
            httpHeader(key: "Accept", value: "application/json")
        ]
        
        return httpHeaders
    }
    
    var method: HTTPMethod {
        switch self{
        default:
            return .get
        }
    }
    
    var body: [String: Any]?{
        return nil
    }
    
}

extension URLRequest{
    mutating func addHeaders(_ Headers:[httpHeader]){
        for Header in Headers {
            self.addValue(Header.value, forHTTPHeaderField: Header.key)
        }
    }
}

extension Bundle {
    var baseURL: String {
        return object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
    }
    
    var urlSubFolder: String {
        return object(forInfoDictionaryKey: "URLSubFolder") as? String ?? ""
    }
}
