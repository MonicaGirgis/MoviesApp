//
//  MovieListVC.swift
//  MoviesApp
//
//  Created by Monica Girgis Kamel on 18/08/2023.
//

import UIKit

class MovieListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var viewModel: MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = MovieListViewModel(moviesRepo: MoviesDataRepo())
        viewModel.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchData()
    }
    
    private func setupUI() {
        title = "Movie List"
        tableView.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? MovieDetailsVC, let movieId = sender as? Int else { return }
        vc.viewModel = MovieDetailsViewModel(id: movieId)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as! MovieTableViewCell
        cell.setData(movie: viewModel.moviesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMovieDetailsVC", sender: viewModel.moviesList[indexPath.row].id)
    }
}

// MARK: - ViewModelDelegates
extension MovieListVC: ViewModelDelegates {
    func autoUpdateView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            tableView.reloadData()
        }
    }
    
    func failedWithError(_ err: String) {
        showAlert(message: err)
    }
    
    func loaderIsHidden(_ isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if isHidden {
                Spinner.hideSpinner()
            }else{
                Spinner.showSpinner()
            }
        }
    }
    
    func insertNewRows(_ initialIndex: Int, _ endIndex: Int, _ section: Int) {
        tableView.beginUpdates()
        let indicies = (initialIndex..<endIndex).map({ IndexPath(row: $0, section: section) })
        tableView.insertRows(at: indicies, with: .automatic)
        tableView.endUpdates()
    }
}
