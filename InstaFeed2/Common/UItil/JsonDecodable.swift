//
//  JsonDecodable.swift
//  InstaFeed2
//
//  Created by Huynh Thanh Dat on 2018/01/11.
//  Copyright © 2018 huynhdat. All rights reserved.
//

import Foundation
typealias JSONDictionary = [String: AnyObject]

protocol JSONDecodable {
    init?(dictionary: JSONDictionary)
}

func decode<T: JSONDecodable>(dictionaries: [JSONDictionary]) -> [T] {
    return dictionaries.flatMap { T(dictionary: $0) }
}

func decode<T: JSONDecodable>(dictionary: JSONDictionary) -> T? {
    return T(dictionary: dictionary)
}

//func decode<T:JSONDecodable>(data: NSData) -> [T]? {
//    guard let JSONObject = try? JSONSerialization.jsonObject(with: data as Data, options: []),
//        let dictionaries = JSONObject as? [JSONDictionary],
//        let objects: [T] = decode(data: dictionaries) else {
//            return nil
//    }
//    
//    return objects
//}

