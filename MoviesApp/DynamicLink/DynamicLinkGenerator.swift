//
//  DynamicLinkGenerator.swift
//  MoviesApp
//
//  Created by Monica Girgis Kamel on 18/08/2023.
//

import Foundation

class DynamicLinkGenerator {
    static func generateDynamicLink(movieId: String) -> URL? {
        let baseUrl = "MyApp://details_screen/"
        let dynamicLink = baseUrl + movieId
        return URL(string: dynamicLink)
    }
}
