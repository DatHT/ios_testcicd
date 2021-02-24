//
//  Date+Ext.swift
//  ProjectTemplate
//
//  Created by sekiguchi-k on 2017/03/23.
//  Copyright © 2017年 sekiguchi-k. All rights reserved.
//

import Foundation

//Dateの拡張クラス
extension Date {
    private func formatterLocaleOfJapanese() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja")
        return formatter
    }
    private static func formatterLocaleOfEnUsPosix() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
    
    // 日付文字列をDateへ変換します （失敗時はnil）
    // let date: Date? = Date.convert("yyyymmdd", "20170316")
    public static func convert(format: String, dateString: String) -> Date? {
        let formatter = self.formatterLocaleOfEnUsPosix()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
    
    // Dateへ日付文字列へ変換します （失敗時はnil）
    // let date: String? = Date.convert("yyyymmdd", Date(NSDate()))
    public static func convert(format: String, date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        let formatter = self.formatterLocaleOfEnUsPosix()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // 年数を取得します。
    // let year = Date.year
    public var year: Int {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year ], from: self)
        guard let year = components.year else {
            return -1
        }
        return year
    }
    
    /// 月数を取得します。
    public var month: Int {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.month ], from: self)
        guard let month = components.month else {
            return -1
        }
        return month
    }
    
    /// 日数を取得します。
    public var day: Int {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.day], from: self)
        guard let day = components.day else {
            return -1
        }
        return day
    }
    
    /// 曜日文字列（日本語）を取得します。<ex.日曜日>
    public var weekdayJapaneseString: String {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        guard let weedayNumber = components.weekday else {
            return ""
        }
        
        let formatter = self.formatterLocaleOfJapanese()
        return formatter.weekdaySymbols[weedayNumber-1]
    }
    
    /// 曜日文字列（日本語）を取得します。<ex.日>
    public var weekdayJapaneseShortString: String {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from:self)
        guard let weedayNumber = components.weekday else {
            return ""
        }
        
        let formatter = self.formatterLocaleOfJapanese()
        return formatter.shortWeekdaySymbols[weedayNumber-1]
    }
    
    // MARK: 比較
    /// 当月であるかを判断します。
    /// 月が判定対象です。
    ///
    /// - parameter date: 比較Date
    ///
    /// - returns: 比較結果（true: 当月, false: 当月外)
    public func isPresentMonth(date: Date?) -> Bool {
        guard let date = date else {
            return false
        }
        let calendar = Calendar(identifier: .gregorian)
        return (calendar.dateComponents([.month], from: self) == calendar.dateComponents([.month], from: date))
    }
    
    /// 対象Date（self）が比較Dateより過去であるかを判断します。
    /// 年月日時分秒が判定対象です。
    /// - parameter date: 比較Date
    /// - returns: 比較結果（true: 過去, false: 未来)
    public func isPast(date: Date?) -> Bool {
        guard let date = date else {
            return false
        }
        return (date.compare(self) == .orderedDescending)
    }
    
    /// 対象Date（self）が比較Dateより未来であるかを判断します。
    /// 年月日時分秒が判定対象です。
    ///
    /// - parameter date: 比較Date
    ///
    /// - returns: 比較結果（true: 未来, false: 過去)
    public func isFuture(date: Date?) -> Bool {
        guard let date = date else {
            return false
        }
        return (date.compare(self) == .orderedAscending)
    }
    
    // MARK: Date要素変更
    /// 指定年数を変更したDateを取得します。
    /// 対象のDateに対する年数の加算減算を行います。
    ///
    /// - parameter year: 年数
    ///
    /// - returns: yearを変更したdate,設定失敗時はnil
    public func add(year: Int) -> Date? {
        return self.add(comp: .year, value: year)
    }
    
    /// 指定月数を変更したDateを取得します。
    /// 対象のDateに対する月数の加算減算を行います。
    ///
    /// - parameter month: 月数
    ///
    /// - returns: monthを変更したdate,設定失敗時はnil
    public func add(month: Int) -> Date? {
        return self.add(comp: .month, value: month)
    }
    
    /// 指定日数を変更したDateを取得します。
    /// 対象のDateに対する日数の加算減算を行います。
    ///
    /// - parameter day: 日数
    ///
    /// - returns: dayを変更したdate,設定失敗時はnil
    public func add(day: Int) -> Date? {
        return self.add(comp: .day, value: day)
    }
    
    /// 指定時間を変更したDateを取得します。
    /// 対象のDateに対する時間の加算減算を行います。
    ///
    /// - parameter hour: 時間
    ///
    /// - returns: hourを変更したdate,設定失敗時はnil
    public func add(hour: Int) -> Date? {
        return self.add(comp: .hour, value: hour)
    }
    
    /// 指定秒数を変更したDateを取得します。
    /// 対象のDateに対する秒数の加算減算を行います。
    ///
    /// - parameter second: 秒数
    ///
    /// - returns: secondを変更したdate,設定失敗時はnil
    public func add(second: Int) -> Date? {
        return self.add(comp: .second, value: second)
    }
    
    private func add(comp: Calendar.Component, value: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(byAdding: comp, value: value, to: self)
    }
    
    /// 時分秒を00:00:00に設定したDateを取得します。
    ///
    /// - returns: 00:00:00のDate, 設定失敗時はnil
    public func firstSecond() -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        guard let date = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: self) else {
            return nil
        }
        return date
    }
    
    /// 時分秒を23:59:59に設定したDateを取得します。
    ///
    /// - returns: 00:00:00のDate, 設定失敗時はnil
    public func lastSecond() -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        guard let date = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self) else {
            return nil
        }
        return date
    }
    
    /// 1日に設定したDateを取得します。
    ///
    /// - returns: 1日のDate, 設定失敗時はnil
    public func firstDay() -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .day], from: self)
        // 当月1日
        components.day = 1
        guard let date = calendar.date(from: components) else {
            return nil
        }
        return date
    }
    
    /// 最終日に設定したDateを取得します。
    /// - returns: 最終日のDate, 設定失敗時はnil
    public func lastDay() -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .day], from: self)
        // 最終日
        let dayRange = calendar.range(of: .day, in: .month, for: self)
        components.day = dayRange?.count
        guard let date = calendar.date(from: components) else {
            return nil
        }
        return date
    }
}

