//
//  MockServerRepository.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/21.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import Foundation
import RxSwift

class MockServerRepository {
    let mock: MockServerDataStore
    init(mockServer: MockServerDataStore) {
        self.mock = mockServer
    }
}

extension MockServerRepository: MockServerProtocol {
    func getMockServer() -> Observable<Dat> {
        return mock.getMockServerData().asObservable()
    }
    
    
}
