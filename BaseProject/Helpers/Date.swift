//
//  Date.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

enum DateFormatEnum: String {

    case DD_MMM                     = "dd MMM"
    case yyyy_MM_dd_T_HH_mm_ss_SSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case yyyyMMdd                   = "yyyy MM dd"
    case yyyy_MM_dd_HH_mm_ss_ZZZ    = "yyyy-MM-dd HH:mm:ss ZZZ"
    case yyyy_MM_dd                 = "yyyy-MM-dd"
    case MM_DD_YYYY                 = "MM/dd/YYYY"
    case DD_MMM_YYYY                = "dd MMM YYYY"
    case yyyy_MM_dd_T_HH_mm_ss_X    = "yyyy-MM-dd'T'HH:mm:ssX"
    case HH_mm_a                    = "HH:mm a"
    case HH_mm_A_D_MMM_YYYY         = "hh:mm a d MMM yyyy"
}

extension Date {
    
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            return true
        }
        return false
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            return true
        }
        
        return false
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            return true
        }
        
        return false
    }
}

extension Date {
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}



extension Date {
    
    static func getFutureDate(WithDays days: Int, FromDate date: Date ) -> Date {
        
        
        var components = DateComponents()
        components.setValue(days, for: .day)
        let futureDate = Calendar.current.date(byAdding: components, to: date)
        return futureDate!
    }
    
    static func getCalenderDateFor(_ date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatEnum.DD_MMM.rawValue
        let DateInFormat = dateFormatter.string(from: date)
        return DateInFormat
    }
    
    
    static func getStringFromDate(date: Date, dateFormat: DateFormatEnum) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        let DateInFormat = dateFormatter.string(from: date)
        return DateInFormat
    }
    
    static func getDateFromString(_ dateString: String, dateFormat: DateFormatEnum, local: Locale = Locale(identifier: "")) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        
        if local.identifier != "" {
            dateFormatter.locale = local
        }
        
        let DateInFormat = dateFormatter.date(from: dateString)
        
        if DateInFormat == nil {
            return Date()
        }
        
        return DateInFormat!
    }
    
    static func getDisplayDateString(_ str: String) -> String {
        
        let date = self.getDateFromString(str, dateFormat: DateFormatEnum.yyyy_MM_dd_HH_mm_ss_ZZZ)
        let dateString = self.getCalenderDateFor(date)
        
        return dateString
    }
    
    
    static func calendarDisplayDateString(_ str: String) -> Date {
        
        let date = self.getDateFromString(str, dateFormat: DateFormatEnum.yyyy_MM_dd_HH_mm_ss_ZZZ)
        return date
    }
    
    static func convertDateString(dateString: String, From form: DateFormatEnum, To to: DateFormatEnum) -> String {
        
        let date = self.getDateFromString(dateString, dateFormat: form)
        let finalDateString = self.getStringFromDate(date: date, dateFormat: to)
        
        return finalDateString
    }
    
    static func getDifferenceBetween(fromdate: String, todate: String, formate: DateFormatEnum) -> Int {
        
        let date = self.getDateFromString(fromdate, dateFormat: formate)
        let date1 = self.getDateFromString(todate, dateFormat: formate)
        return date.days(from: date1)
    }
    
    func localToUTC(date:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatEnum.yyyyMMdd.rawValue
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = DateFormatEnum.yyyyMMdd.rawValue
        
        return dateFormatter.string(from: dt!)
    }
    
    func UTCToLocal(date:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatEnum.yyyyMMdd.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = DateFormatEnum.yyyyMMdd.rawValue
        
        return dateFormatter.string(from: dt!)
    }
    
    static func getMessagetime(dateString: String, isHeader : Bool = false)-> String {
        
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = DateFormatEnum.yyyy_MM_dd_T_HH_mm_ss_SSSZ.rawValue
        dateFormate.locale = Locale(identifier: "en_US_POSIX")
        dateFormate.timeZone = TimeZone(abbreviation:"UTC")
        let date = dateFormate.date(from: dateString)
        let day = date?.days(from: Date())
        
        if day == 0 {
            if isHeader {
                return "Today"
            }
            else {
                return "\(self.getTimeForMeassge(date ?? Date(), DateFormatEnum.HH_mm_a.rawValue))"
            }
        }
        else if day == 1 {
            if isHeader {
                return "Yesterday"
            }
            else {
                return "Yesterday at \(self.getTimeForMeassge(date ?? Date(), DateFormatEnum.HH_mm_a.rawValue))"
            }
        }
        else {
            if isHeader {
                return self.getTimeForMeassge(date ?? Date(), DateFormatEnum.DD_MMM_YYYY.rawValue)
            }else {
                return self.getTimeForMeassge(date ?? Date(), DateFormatEnum.HH_mm_A_D_MMM_YYYY.rawValue)
            }
        }
    }
    
    static private func getTimeForMeassge(_ date: Date, _ formate: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
}
