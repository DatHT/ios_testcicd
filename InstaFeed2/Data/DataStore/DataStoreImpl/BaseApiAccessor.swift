//
//  BaseApiAccessor.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
class BaseApiAccessor {
    
    
    
     func handleData<T>(data: Data?, response: URLResponse?, error : Error?) -> T? where T: Codable {
        if error != nil {
            print(error!.localizedDescription)
        }
        guard let data = data else {
            return nil
        }
        do {
            let data = try JSONDecoder().decode(T.self, from: data)
            return data
        } catch let jsonError {
            print(jsonError)
            return nil
        }
    }
}
