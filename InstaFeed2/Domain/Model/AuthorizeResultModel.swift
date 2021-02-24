//
//  AuthorizeResultModel.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/07.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
class AuthorizeResultModel {
    var result: Bool
    var message: String
    
    init(result: Bool, message: String) {
        self.result = result
        self.message = message
    }
}
