//
//  MovieRepositoryProtocol.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieRepositoryProtocol {
    func getListMoviesNowPlaying(page: Int) -> GetMovieListResultModel
    
    func getListMoviesRx(page: Int) -> Observable<GetMovieListResultModel>
    
    func getListMoviesRx2(page: Int) -> Single<GetMovieListResultModel>
}
