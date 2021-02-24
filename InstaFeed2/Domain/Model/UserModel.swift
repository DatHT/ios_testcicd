//
//  UserModel.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/06.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation

class UserModel {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
