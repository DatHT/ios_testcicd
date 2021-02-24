//
//  MovieDetailViewController.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/11/29.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var backdropUrl: UIImageView!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    let prefixURl = "https://image.tmdb.org/t/p/w500"
    
    var movieData : Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        backdropUrl.setImageWith(URL(string: prefixURl + (movieData?.imageUrl)!)!)
        movieTitle.text = movieData?.title
        movieReleaseDate.text = movieData?.releaseDate
        movieRating.text = String(describing: movieData?.voteAverage)
        movieOverview.text = movieData?.overview
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
