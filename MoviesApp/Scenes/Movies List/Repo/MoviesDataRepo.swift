//
//  MoviesDataRepo.swift
//  MoviesApp
//
//  Created by Monica Girgis Kamel on 18/08/2023.
//

import Foundation

class MoviesDataRepo {
     
    func fetchMovies(page: Int, completion: ((Result<APIResponse<[MovieModel]>, APIError>)->())?) {
        APIRoute.shared.fetchRequest(clientRequest: .getData(page: page), decodingModel: APIResponse<[MovieModel]>.self) { result in
            completion?(result)
        }
    }
}
