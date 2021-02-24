//
//  MovieViewCell.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/11/28.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import UIKit
import AFNetworking

class MovieViewCell: UITableViewCell {
    @IBOutlet weak var imagePath: UIImageView!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var title: UILabel!
    
    let prefixURl = "https://image.tmdb.org/t/p/w500"
    var movie : Movie? {
        didSet {
            title.text = movie?.title
            overview.text = movie?.overview
            //load image
            imagePath.setImageWith(URL(string: prefixURl + (movie?.imageUrl)!)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
