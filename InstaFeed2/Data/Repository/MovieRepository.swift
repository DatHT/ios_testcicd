//
//  MovieRepository.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import RxSwift

class MovieRepository {
    let getMovie : MovieDataStore
    init(getMovie: MovieDataStore) {
        self.getMovie = getMovie
    }
    
}

extension MovieRepository: MovieRepositoryProtocol {
    
    func getListMoviesRx(page: Int) -> Observable<GetMovieListResultModel> {
        return getMovie.getFetchMoviesRx(page: page).asObservable().map {data in
            print("--------Movie data-------")
            for item in data.results {
                print(item.title)
            }
            
            return GetMovieListResultModel(movies: data, businessDate: "", success: true, message: "")
        }
    }
    
    func getListMoviesNowPlaying(page: Int) -> GetMovieListResultModel {
        let data = getMovie.getFetchMovies(page: page)
        return GetMovieListResultModel(movies: data.value, businessDate: "", success: data.success, message: data.message)
        
    }
    
    func getListMoviesRx2(page: Int) -> Single<GetMovieListResultModel> {
        return getMovie.getFetchMoviesRx(page: page).map {data in
            return GetMovieListResultModel(movies: data, businessDate: "", success: true, message: "")
        }
    }
    
}
