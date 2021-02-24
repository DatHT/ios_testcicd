//
//  GetMovieListResultModel.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation

class GetMovieListResultModel {
    var success : Bool
    var movies : MovieResult?
    var businessDate : String
    var message : String
    
    init(movies : MovieResult?, businessDate: String, success: Bool, message: String) {
        self.movies = movies
        self.businessDate = businessDate
        self.success = success
        self.message = message
    }
}
