//
//  String+Parser.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
enum Parse: Error {
    case IntError
    case IntError16
    case StringError
    case DoubleError
    case DateError
}

extension String {
    func toInt() throws -> Int {
        if let con = Int(self) {
            return con
        } else {
            throw Parse.IntError
        }
    }
    
    func toDouble() throws -> Double {
        if let con = Double(self) {
            return con
        } else {
            throw Parse.DoubleError
        }
    }
    
    func toDate() throws -> Date {
        let splitStr = self.components(separatedBy: "/")
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let date = calendar.date(from: DateComponents(year: Int(splitStr[0])!,
                                                      month: Int(splitStr[1])!,
                                                      day: Int(splitStr[2])!))!
        if type(of: date) == Date.self {
            return date
        } else {
            throw Parse.DateError
        }
    }
    
    
}
