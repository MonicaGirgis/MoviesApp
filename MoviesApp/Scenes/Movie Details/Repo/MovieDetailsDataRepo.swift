//
//  MovieDetailsDataRepo.swift
//  MoviesApp
//
//  Created by Monica Girgis Kamel on 18/08/2023.
//

import Foundation

class MovieDetailsDataRepo {
    
    func getMovieDetails(with id: Int, completion: ((Result<MovieDetailsModel, APIError>)->())?) {
        APIRoute.shared.fetchRequest(clientRequest: .getDetails(id: id), decodingModel: MovieDetailsModel.self) { result in
            completion?(result)
        }
    }
}
