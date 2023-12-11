//
//  CalendarHandler.swift
//  Calendar
//
//  Created by Владислав Лесовой on 11.12.2023.
//

import Foundation
extension CalendarDateRow{
    @MainActor class CalendarVM: ObservableObject{
        
        @Published public var days: [[Day]] = [[],[],[],[],[],[]]
        static let months: [String] = ["", "Январь", "Февраль", "Марта", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
        
        private var daysOfWeek: [Int] = [0, 7, 1, 2, 3, 4, 5, 6]
        var daysArrayCounter: Int = 0
        
        var currentMonth: Int = 1
        var currentYear: Int  = 2023
        var startDayOfWeek: Int = 1
        var currentDate = Date.now
        let formatter = DateFormatter()
        
        init() {
            formatter.dateFormat = "dd-MM-yyyy"
            startOfMonth()
            fillMonth()
        }
        
        func nextMonth() -> Void{
            changeMonth(much: 1)
        }
        
        func previousMonth() -> Void{
            changeMonth(much: -1)
        }
        
        func nextYear() -> Void{
            changeYear(much: 1)
        }
        
        func previousYear() -> Void{
            changeYear(much: -1)
        }
        
        func setYear(year: Int) -> Void{
            currentYear = year
            startOfMonth()
            fillMonth()
        }
        private func isLeapYear(year: Int) -> Bool{
            if year % 400 == 0{
                return true
            }
            if year % 100 == 0{
                return false
            }
            if year % 4 == 0 {
                return true
            }
            return false
        }
        public func getMonth(much: Int) -> Int{
            let month: Int = currentMonth + much
            if month > 12{
                return 1
            }
            if month < 1 {
                return 12
            }
            return month
        }
        private func changeYear(much: Int) -> Void{
            currentYear += much
            if currentYear < 1 || currentYear > 2100{
                currentYear -= 1
                return
            }
            startOfMonth()
            fillMonth()
        }
        
        private func changeMonth(much: Int) -> Void{
            currentMonth += much
            if currentMonth > 12{
                if currentYear > 2100{
                    currentMonth -= much
                    return
                }
                currentMonth = 1
                changeYear(much: 1)
            }
            if currentMonth < 1{
                if currentYear < 2{
                    currentMonth += much
                    return
                }
                currentMonth = 12
                changeYear(much: -1)
            }
            startOfMonth()
            fillMonth()
        }
        func goBack() -> Void{
            currentDate =  Date.now
            currentYear = Calendar.current.component(.year, from: currentDate)
            currentMonth = Calendar.current.component(.month, from: currentDate)
            startOfMonth()
            fillMonth()
        }
        private func startOfMonth() -> Void{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let day: String = "01"
            let month: String = String(currentMonth).count == 1 ? "0\(currentMonth)" : String(currentMonth)
            let dateString: String = " \(day)-\(month)-\(currentYear)"
            startDayOfWeek = daysOfWeek[Int(Calendar.current.component(.weekday, from: formatter.date(from: dateString)!))]
        }
        
        private func daysInMonth(month: Int, year: Int) -> Int{
            if month == 2{
                if isLeapYear(year: year){
                    return 29
                }
                else{
                    return 28
                }
            }
            if [1, 3, 5, 7, 8, 10, 12].contains(month){
                return 31
            }
            return 30
        }
        
        private func fillMonth() -> Void{
            days = [[],[],[],[],[],[]]
            startOfMonth()
            if startDayOfWeek > 1{
                let month: Int = getMonth(much: -1)
                let year: Int = month == 12 ? currentYear + 1 : currentYear
                fillDays(range: daysInMonth(month: month, year: year) - (startDayOfWeek - 2)...daysInMonth(month: month, year: year), month: month, countFrom: 0)
            }
            fillDays(range: 1...daysInMonth(month: getMonth(much: 0), year: currentYear), month: currentMonth, countFrom: 0, active: true)
            print(1...(7 - self.days[5].count))
            let counterStart: Int = days[4].count < 7 ? 4 : 5
            fillDays(range: 1...((7 - days[4].count) + (7 - days[5].count)), month: getMonth(much: +1), countFrom: counterStart)
        }
        
        private func fillDays(range: ClosedRange<Int>, month: Int, countFrom : Int, active: Bool = false) -> Void{
            var c: Int = countFrom
            for i in range{
                if days[c].count > 6 {
                    c += 1
                    continue
                }
                let day: String = String(i).count == 1 ? "0\(i)" : String(i)
                let month: String = String(month).count == 1 ? "0\(month)" : String(month)
                let dateString: String = " \(day)-\(month)-\(currentYear)"
                days[c].append(Day(dayString: dateString, isActive: active))
                if days[c].count > 6 {
                    c += 1
                }
            }
        }
    }
}

