//
//  NSDate+Extensions.swift
//  SwiftNSDateExtensions
//
//  Created by Freddy on 10/4/14.
//
//

import Foundation

let D_SECOND = 1
let D_MINUTE = 60
let D_HOUR = 3600
let D_DAY = 86400
let D_WEEK = 604800
let D_YEAR = 31556926

// var sharedCalendar:NSCalendar = nil

let componentFlags: NSCalendar.Unit = [.year, .month, .day, .weekOfMonth, .hour, .minute, .second, .weekday, .weekdayOrdinal]
extension Date {
        
    static func currentCalendar() -> Calendar {
        //
        //        if (sharedCalendar == nil){
        //            sharedCalendar = NSCalendar.autoupdatingCurrentCalendar()
        //        }
        return Calendar.autoupdatingCurrent
    }
    
    // Relative dates from the current date
    static func dateTomorrow() -> Date {
        return Date().dateByAddingsDays(1)
    }
    
    static func dateYesterday() -> Date {
        return Date().dateBySubtractingDays(1)
    }
    
    static func dateWithDaysFromNow(_ days: NSInteger) -> Date {
        return Date().dateByAddingsDays(days)
    }
    
    static func dateWithDaysBeforeNow(_ days: NSInteger) -> Date {
        return Date().dateBySubtractingDays(days)
    }
    
    static func dateWithHoursFromNow(_ dHours: NSInteger) -> Date {
        let aTimeInterval: TimeInterval = Date().timeIntervalSinceReferenceDate + Double(D_HOUR) * Double(dHours)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    static func dateWithHoursBeforeNow(_ dHours: NSInteger) -> Date {
        let aTimeInterval: TimeInterval = Date().timeIntervalSinceReferenceDate - Double(D_HOUR) * Double(dHours)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    static func dateWithMinutesFromNow(_ dMinutes: NSInteger) -> Date {
        let aTimeInterval: TimeInterval = Date().timeIntervalSinceReferenceDate + Double(D_MINUTE) * Double(dMinutes)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    static func dateWithMinutesBeforeNow(_ dMinutes: NSInteger) -> Date {
        let aTimeInterval: TimeInterval = Date().timeIntervalSinceReferenceDate - Double(D_MINUTE) * Double(dMinutes)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    static func dateWithSecondsFromNow(_ dSeconds: NSInteger) -> Date {
        let aTimeInterval: TimeInterval = Date().timeIntervalSinceReferenceDate + Double(dSeconds)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    static func dateWithSecondsBeforeNow(_ dSeconds: NSInteger) -> Date {
        let aTimeInterval: TimeInterval = Date().timeIntervalSinceReferenceDate - Double(dSeconds)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
        
    // Comparing dates
    func isEqualToDateIgnoringTime(_ aDate: Date) -> Bool {
        let components1 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        let components2 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: aDate)
        
        return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day))
    }
    
    func isToday() -> Bool {
        return self.isEqualToDateIgnoringTime(Date())
    }
    
    func isTomorrow() -> Bool {
        return self.isEqualToDateIgnoringTime(Date.dateTomorrow())
    }
    
    func isYesterday() -> Bool {
        return self.isEqualToDateIgnoringTime(Date.dateYesterday())
    }
    
    func isSameWeekAsDate(_ aDate: Date) -> Bool {
        let components1 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        let components2 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: aDate)
        
        if (components1.weekOfYear != components2.weekOfYear) {
            return false
        }
        
        // Must have a time interval under 1 week. Thanks @aclark
        return (abs(NSInteger(self.timeIntervalSince(aDate))) < D_WEEK)
    }
    
    func isThisWeek() -> Bool {
        return self.isSameWeekAsDate(Date())
    }
    
    func isNextWeek() -> Bool {
        let aTimeInterval = Date().timeIntervalSinceReferenceDate + Double(D_WEEK)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return self.isSameWeekAsDate(newDate)
    }
    
    func isLastWeek() -> Bool {
        let aTimeInterval = Date().timeIntervalSinceReferenceDate - Double(D_WEEK)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return self.isSameWeekAsDate(newDate)
    }
    
    func isSameMonthAsDate(_ aDate: Date) -> Bool {
        let components1 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        let components2 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: aDate)
        
        return ((components1.month == components2.month) && (components1.year == components2.year))
    }

    func isSameDayAsDate(_ aDate: Date) -> Bool {
        let components1 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        let components2 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: aDate)
        
        return ((components1.month == components2.month) && (components1.day == components2.day) && (components1.year == components2.year))
    }

    func isThisMonth() -> Bool {
        return self.isSameMonthAsDate(Date())
    }
    
    func isNextMonth() -> Bool {
        return self.isSameMonthAsDate(Date().dateByAddingsMonths(1))
    }
    
    func isLastMonth() -> Bool {
        return self.isSameMonthAsDate(Date().dateBySubtractingMonths(1))
    }
    
    func isSameYearAsDate(_ aDate: Date) -> Bool {
        let components1 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        let components2 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: aDate)
        
        return (components1.year == components2.year)
    }
    
    func isThisYear() -> Bool {
        return self.isSameYearAsDate(Date())
    }
    
    func isNextYear() -> Bool {
        let components1 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        let components2 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: Date())
        
        return (components1.year! == (components2.year! + 1))
    }
    
    func isLastYear() -> Bool {
        let components1 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        let components2 = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: Date())
        
        return (components1.year! == (components2.year! - 1))
    }
    
    func isEarlierThanDate(_ aDate: Date) -> Bool {
        return (self.compare(aDate) == ComparisonResult.orderedAscending)
    }
    
    func isLaterThanDate(_ aDate: Date) -> Bool {
        return (self.compare(aDate) == ComparisonResult.orderedDescending)
    }
    
    func isInFuture() -> Bool {
        return self.isLaterThanDate(Date())
    }
    
    func isInPast() -> Bool {
        return self.isEarlierThanDate(Date())
    }
    
    // Date roles
    func isTypicallyWorkday() -> Bool {
        let components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        if (components.weekday == 1 || components.weekday == 7) {
            return true
        }
        return false
    }
    
    func isTypicallyWeekend() -> Bool {
        return !isTypicallyWorkday()
    }
    
    // Adjusting dates
    func dateByAddingsYears(_ dYears: NSInteger) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        let newDate = (Date.currentCalendar() as NSCalendar).date(byAdding: dateComponents, to: self, options: [])
        
        return newDate!
        
    }
    
    func dateBySubtractingYears(_ dYears: NSInteger) -> Date {
        
        return self.dateByAddingsYears(dYears * -1)
    }
        
    func dateByAddingsMonths(_ dYMonths: NSInteger) -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = dYMonths
        
        let newDate = (Date.currentCalendar() as NSCalendar).date(byAdding: dateComponents, to: self, options: [])
        
        return newDate!
    }
    
    func dateBySubtractingMonths(_ dYMonths: NSInteger) -> Date {
        
        return self.dateByAddingsYears(dYMonths * -1)
    }
    
    func dateByAddingsDays(_ dDays: NSInteger) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = dDays
        
        let newDate = (Date.currentCalendar() as NSCalendar).date(byAdding: dateComponents, to: self, options: [])
        
        return newDate!
    }
    
    func dateBySubtractingDays(_ dDays: NSInteger) -> Date {
        return self.dateByAddingsDays(dDays * -1)
    }
    
    func dateByAddingHours(_ dHours: NSInteger) -> Date {
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(D_HOUR) * Double(dHours)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    func dateBySubtractingHours(_ dHours: NSInteger) -> Date {
        return self.dateByAddingHours((dHours * -1))
    }
    
    func dateByAddingMinutes(_ dMinutes: NSInteger) -> Date {
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(D_MINUTE) * Double(dMinutes)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        
        return newDate
    }
    
    func dateBySubtractingMinutes(_ dMinutes: NSInteger) -> Date {
        return self.dateByAddingMinutes((dMinutes * -1))
    }
    
    func dateByAddingSeconds(_ dSeconds: NSInteger) -> Date {
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(D_SECOND) * Double(dSeconds)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        
        return newDate
    }
    
    func dateBySubtractingSeconds(_ dSeconds: NSInteger) -> Date {
        return self.dateByAddingSeconds((dSeconds * -1))
    }

    // Date extremes
    
    func dateAtStartOfDay() -> Date {
        var components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        return Date.currentCalendar().date(from: components)!
    }
    
    func dateAtEndOfDay() -> Date {
        var components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        components.hour = 23
        components.minute = 59
        components.second = 59
        return Date.currentCalendar().date(from: components)!
    }
    
    func dateAtStartOfNextHour() -> Date {
        var components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        if let hour = components.hour {
            components.hour = hour + 1
            components.minute = 0
            components.second = 0
        }
        return Date.currentCalendar().date(from: components)!
    }

    // Retrieving intervals
    // TODO : - (NSInteger) minutesAfterDate: (NSDate *) aDate
    // TODO : - (NSInteger) minutesBeforeDate: (NSDate *) aDate
    // TODO : - (NSInteger) hoursAfterDate: (NSDate *) aDate
    // TODO : - (NSInteger) hoursBeforeDate: (NSDate *) aDate
    // TODO : - (NSInteger) daysAfterDate: (NSDate *) aDate
    // TODO : - (NSInteger) daysBeforeDate: (NSDate *) aDate
    // TODO : - (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
    
    func stringWithDateStyle(_ dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    
    func stringWithFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var shortString: String {
        return stringWithDateStyle(DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
    }
    
    var shortDateString: String {
        return stringWithDateStyle(DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
    }
    
    var shortTimeString: String {
        return stringWithDateStyle(DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
    }
    
    var mediumString: String {
        return stringWithDateStyle(DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
    
    var mediumDateString: String {
        return stringWithDateStyle(DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
    }
    
    var mediumTimeString: String {
        return stringWithDateStyle(DateFormatter.Style.none, timeStyle: DateFormatter.Style.medium)
    }
    
    var longString: String {
        return stringWithDateStyle(DateFormatter.Style.long, timeStyle: DateFormatter.Style.long)
    }
    
    var longDateString: String {
        return stringWithDateStyle(DateFormatter.Style.long, timeStyle: DateFormatter.Style.none)
    }
    
    var longTimeString: String {
        return stringWithDateStyle(DateFormatter.Style.none, timeStyle: DateFormatter.Style.long)
    }
    
    var nearestHour: NSInteger {
        let aTimeInterval = Date.timeIntervalSinceReferenceDate + Double(D_MINUTE) * Double(30)
        
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        let components = (Date.currentCalendar() as NSCalendar).components([.hour], from: newDate)
        return components.hour!
    }
    
    var hour: NSInteger {
        let components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        return components.hour!
    }
    
    var minute: NSInteger {
        let components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        return components.minute!
    }
    
    var seconds: NSInteger {
        let components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        return components.second!
    }
    
    var day: NSInteger {
        let components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        return components.day!
    }
    
    var month: NSInteger {
        let components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        return components.month!
    }
    
    var week: NSInteger {
        let components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        return components.weekOfYear!
    }
    
    var weekday: NSInteger {
        let components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        return components.weekday!
    }
    
    var nthWeekday: NSInteger { // e.g. 2nd Tuesday of the month is 2
        let components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        return components.weekdayOrdinal!
    }
    
    var year: NSInteger {
        let components = (Date.currentCalendar() as NSCalendar).components(componentFlags, from: self)
        return components.year!
    }
}
