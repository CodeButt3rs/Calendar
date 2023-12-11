//
//  Calendar.swift
//  Calendar
//
//  Created by Владислав Лесовой on 11.12.2023.
//

import Foundation

extension Date {
    var startOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
}

struct Year{
    init(yearInt: Int, months: [Month]) {
        self.yearInt = yearInt
        self.months = months
    }
    
    var yearInt: Int
    var yearString: String {get {String(yearInt)}}
    var months: [Month]
}
struct Month{
    
    init(monthInt: Int, days: [Day]) {
        self.monthInt = monthInt
        self.days = days
    }
    
    let months: [String] = ["", "Январь", "Февраль", "Марта", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    
    var monthInt: Int
    var monthString: String {get {months[monthInt]}}
    var days: [Day]
}
struct Day{
    init(dayInt: Int) {
        self.dayInt = dayInt
    }
    var dayInt: Int
    var dayString: String {get {String(dayInt)}}
}
