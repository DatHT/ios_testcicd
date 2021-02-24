//
//  Movie.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/11/28.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String
    let imageUrl: String?
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    
    
    private enum CodingKeys : String, CodingKey {
        case title, imageUrl = "poster_path", overview, voteAverage = "vote_average", releaseDate = "release_date"
        
    }
}
