//
//  UserDataStore.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/06.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation

protocol UserDataStore {
    func login(username: String, password: String) -> AuthorizeResultModel
    func register(username: String, password: String)
}
