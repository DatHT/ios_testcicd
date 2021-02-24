//
//  ErrorHandler.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/11.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import Foundation

enum Method: String {
    case GET = "GET"
    case POST = "POST"
}

protocol Resource {
    var method: Method {get}
    var path: String {get}
    var parameters: [String: String] {get}
}

extension Resource {
    
    var method: Method {
        return .GET
    }
    
}
