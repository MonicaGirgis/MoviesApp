//
//  MovieDetailsVC.swift
//  MoviesApp
//
//  Created by Monica Girgis Kamel on 18/08/2023.
//

import UIKit

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var viewModel = MovieDetailsViewModel(id: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchData()
    }
    

    private func setData() {
        
        titleLabel.text = viewModel.details?.title
        contentLabel.text = viewModel.details?.overview
        authorLabel.text = "\(viewModel.details?.runtime ?? 0) " + "min"
        sourceLabel.text = "\(viewModel.details?.voteAverage ?? 0)"
        dateLabel.text = viewModel.details?.releaseDate
        contentImageView.getAsync(viewModel.details?.posterPath ?? "")
        sourceImageView.getAsync(viewModel.details?.backdropPath ?? "")
    }

}

extension MovieDetailsVC: ViewModelDelegates {
    func autoUpdateView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            setData()
        }
    }
    
    func failedWithError(_ err: String) {
        showAlert(message: err)
    }
    
    func loaderIsHidden(_ isHidden: Bool) {
        DispatchQueue.main.async {
            if isHidden {
                Spinner.hideSpinner()
            }else{
                Spinner.showSpinner()
            }
        }
    }
    
    func insertNewRows(_ initialIndex: Int, _ endIndex: Int, _ section: Int) {
    }
}
