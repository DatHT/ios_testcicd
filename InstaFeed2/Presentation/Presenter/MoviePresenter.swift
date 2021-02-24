//
//  MoviePresenter.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/05.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import RxSwift

protocol MoviePresenter {
//    var movies: Observable<[Movie]> {get set}
}

extension MoviePresenter {
    
    
    func getListMovieNowPlaying(p : Int) -> [Movie] {
        let result = ManagementMovie().getListMovieNowPlaying(page: p)
        if result.success {
            return (result.movies?.results)!
        } else {
            return [Movie]()
        }
    }
    
    func getMoviesNowPlayingRx(p: Int) -> Single<[Movie]> {
        return ManagementMovie().getListMoviesManageRx(page: p).map{data in
            return (data.movies?.results)!
        }
    }
    
    func getMockServerData() -> Single<ResultUpdateDataModel> {
        return ManagementMockServer().getMockServerData()
    }
}
