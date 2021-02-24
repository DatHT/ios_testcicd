//
//  MockServerDataStore.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/21.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import Foundation
import RxSwift

protocol MockServerDataStore {
    func getMockServerData() -> Single<Dat>
}
