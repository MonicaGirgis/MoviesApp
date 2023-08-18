//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Monica Girgis Kamel on 18/08/2023.
//

import Foundation

class MovieDetailsViewModel {
    
    let id: Int?
    let movieDetailsRepo: MovieDetailsDataRepo
    
    var details: MovieDetailsModel?
    var delegate: ViewModelDelegates?
    
    init(id: Int?) {
        self.id = id
        movieDetailsRepo = MovieDetailsDataRepo()
    }
    
    func fetchData() {
        guard let id = id else { return }
        delegate?.loaderIsHidden(false)
        movieDetailsRepo.getMovieDetails(with: id) { [weak self] result in
            guard let self = self else { return }
            delegate?.loaderIsHidden(true)
            switch result {
            case .success(let data):
                details = data
                delegate?.autoUpdateView()
            case .failure(let error):
                delegate?.failedWithError(error.localizedDescription)
            }
        }
    }
}
