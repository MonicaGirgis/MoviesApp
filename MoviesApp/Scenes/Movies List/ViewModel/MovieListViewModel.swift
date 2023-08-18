//
//  MovieListViewModel.swift
//  MoviesApp
//
//  Created by Monica Girgis Kamel on 18/08/2023.
//

import Foundation

class MovieListViewModel {
    
    private (set) var moviesList: [MovieModel] = []
    private (set) var page: Int = 1
    private (set) var totalPages: Int = 0
    
    var delegate: ViewModelDelegates?
    
    let moviesRepo: MoviesDataRepo
    
    init(moviesRepo: MoviesDataRepo) {
        self.moviesRepo = moviesRepo
    }
    
    func fetchData() {
        delegate?.loaderIsHidden(false)
        moviesRepo.fetchMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            delegate?.loaderIsHidden(true)
            switch result {
            case .success(let data):
                totalPages = data.total_pages ?? 0
                
                if page == 1 {
                    moviesList = data.results
                    delegate?.autoUpdateView()
                }else{
                    let intialIndex = moviesList.count - 1
                    moviesList.append(contentsOf: data.results)
                    let endIndex = moviesList.count - 1
                    delegate?.insertNewRows(intialIndex, endIndex, 0)
                }
                
            case .failure(let error):
                delegate?.failedWithError(error.localizedDescription)
            }
        }
    }
}
