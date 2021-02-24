//
//  ManagementMockServer.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/21.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import Foundation
import RxSwift

class ManagementMockServer {
    var repo : MockServerProtocol {
        return DIContainer.resolve(serviceType: MockServerProtocol.self)
    }
    
    var movieRepository : MovieRepositoryProtocol {
        return DIContainer.resolve(serviceType: MovieRepositoryProtocol.self)
    }
    
    func getMockServerData() -> Single<ResultUpdateDataModel> {
        //get movie first
        var result = true
        return movieRepository.getListMoviesRx(page: 1).flatMap{data in
            self.repo.getMockServer()
            }.asSingle().map{data2 in
                print("--- mock data-----")
                print("\(data2.name)-\(data2.age)-\(data2.car)")
                
                //start download Service
                let rs1 = Resources(downloadUrl: URL(string: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music3/v4/40/6c/4d/406c4d92-5858-698d-ab2b-0d549145c41b/mzaf_2175756654202971871.plus.aac.p.m4a")!)
                let rs2 = Resources(downloadUrl: URL(string: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music/v4/2c/c9/81/2cc981d8-8087-fec8-7b00-5f0713a210ea/mzaf_5485831532149473385.plus.aac.p.m4a")!)
                let rs3 = Resources(downloadUrl: URL(string: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music5/v4/5f/02/06/5f020649-c65c-778c-b79f-5f510078297c/mzaf_8225124034985989653.plus.aac.p.m4a")!)
                
                let service = DownloadServiceMamangement()
                service.downloadService.startDownload(rs1)
                service.downloadService.startDownload(rs2)
                service.downloadService.startDownload(rs3)
                
                
                return ResultUpdateDataModel(result: result)
        }
        
    }
}
