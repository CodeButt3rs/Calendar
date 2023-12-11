//
//  CalendarHandler.swift
//  Calendar
//
//  Created by Владислав Лесовой on 11.12.2023.
//

import Foundation
extension CalendarDateRow{
    @MainActor class CalendarVM: ObservableObject{
        
        @Published public var days: [[String]] = [[],[],[],[],[],[]]
        
        private var daysOfWeek: [Int] = [0, 7, 1, 2, 3, 4, 5, 6]
        
        var daysArrayCounter: Int = 0
        
        var currentMonth: Int = 12
        var currentYear: Int  = 2023
        var startDayOfWeek: Int = 1
        var currentDate = Date.now
        let formatter = DateFormatter()
        
        init() {
            
            formatter.dateFormat = "dd-MM-yyyy"
//            formatter.
            startOfMonth()
            fillMonth()
            print(startDayOfWeek - 2)
//            print(days)
        }
        func nextMonth() -> Void{
            changeMonth(much: 1)
        }
        
        func previousMonth() -> Void{
            changeMonth(much: -1)
        }
        private func getMonth(much: Int) -> Int{
            let month: Int = currentMonth + much
            if month > 12{
                return 1
            }
            if month < 0 {
                return 12
            }
            return month
        }
        
        private func changeMonth(much: Int) -> Void{
            currentMonth += much
            if currentMonth > 12{
                currentMonth = 1
                currentYear += 1
            }
            if currentMonth < 1{
                currentMonth = 12
                currentYear -= 1
            }
            startOfMonth()
            fillMonth()
        }
        
        private func startOfMonth() -> Void{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let day: String = "01"
            let month: String = String(currentMonth).count == 1 ? "0\(currentMonth)" : String(currentMonth)
            let dateString: String = " \(day)-\(month)-\(currentYear)"
//            print(daysOfWeek[Int(Calendar.current.component(.weekday, from: formatter.date(from: dateString)!))])
            startDayOfWeek = daysOfWeek[Int(Calendar.current.component(.weekday, from: formatter.date(from: dateString)!))]
        }
        
        private func daysInMonth(month: Int) -> Int{
            if month == 2{
                if currentYear % 4 == 0{
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
                fillDays(range: daysInMonth(month: month) - (startDayOfWeek - 2)...daysInMonth(month: month), month: month, countFrom: 0)
            }
            fillDays(range: 1...daysInMonth(month: getMonth(much: 0)), month: currentMonth, countFrom: 0)
            print(1...(7 - self.days[5].count))
            let counterStart: Int = days[4].count < 7 ? 4 : 5
            fillDays(range: 1...((7 - days[4].count) + (7 - days[5].count)), month: getMonth(much: +1), countFrom: counterStart)
        }
        
        private func fillDays(range: ClosedRange<Int>, month: Int, countFrom : Int) -> Void{
            var c: Int = countFrom
            for i in range{
                if days[c].count > 6 {
                    c += 1
                    continue
                }
                let day: String = String(i).count == 1 ? "0\(i)" : String(i)
                let month: String = String(month).count == 1 ? "0\(month)" : String(month)
                let dateString: String = " \(day)-\(month)-\(currentYear)"
                days[c].append(dateString)
                if days[c].count > 6 {
                    c += 1
                }
            }
        }
    }
}

