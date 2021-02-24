//
//  ManagementMovie.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/05.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import RxSwift

class ManagementMovie {
    var movieRepository : MovieRepositoryProtocol {
        return DIContainer.resolve(serviceType: MovieRepositoryProtocol.self)
    }
    
    func getListMovieNowPlaying(page : Int) -> GetMovieListResultModel {
        return movieRepository.getListMoviesNowPlaying(page: page)
    }
    
    func getListMoviesManageRx(page: Int) -> Single<GetMovieListResultModel> {
        return movieRepository.getListMoviesRx(page: page).asSingle()
    }
}
