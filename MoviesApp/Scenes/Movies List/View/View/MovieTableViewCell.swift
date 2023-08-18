//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Monica Girgis Kamel on 18/08/2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var newsPaperLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    @IBOutlet weak var saveLaterButton: UIButton!
    
    var saveLater: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI(){
        movieImageView.makeRoundedCornersWith(radius: 8.0)
    }
    
    func setData(movie: MovieModel){
        movieImageView.getAsync(movie.posterPath)
        headLineLabel.text = movie.originalTitle
        newsPaperLabel.text = "\(movie.voteAverage)"
        descriptionLabel.text = movie.overview
        datePostedLabel.text = movie.releaseDate
    }
    
    private func setData(date: Date)->String{
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "MMM d, h:mm a"
        return newDateFormatter.string(from: date)
    }
    
    @IBAction func saveLaterAction(_ sender: Any) {
        saveLater?()
    }
}
