//
//  MovieDataStore.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieDataStore {
    func getFetchMovies(page: Int) -> (success: Bool, value: MovieResult?, message: String)
    
    func getFetchMoviesRx(page: Int) -> Single<MovieResult>
}
