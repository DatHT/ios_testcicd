//
//  EnumEnumurable.swift
//  InstaFeed2
//
//  Created by huynh-dat on 2017/12/04.
//  Copyright © 2017 huynhdat. All rights reserved.
//

import Foundation
public protocol EnumEnumurable {
    associatedtype Case = Self
}

public extension EnumEnumurable where Case : Hashable {
    private static var itorator : AnyIterator<Case> {
        var n = 0
        return AnyIterator {
            defer {n += 1}
            let next = withUnsafePointer(to: &n) {
                UnsafeRawPointer($0).assumingMemoryBound(to: Case.self).pointee
            }
            return next.hashValue == n ? next : nil
        }
    }
    
    public static func enumerate() -> EnumeratedSequence<AnySequence<Case>> {
        return AnySequence(self.itorator).enumerated()
    }
    
    public static var cases: [Case] {
        return Array(Self.itorator)
    }
    
    public static var count: Int {
        return self.cases.count
    }
}
