//
//  CalendarDate.swift
//  Calendar
//
//  Created by Владислав Лесовой on 11.12.2023.
//

import SwiftUI

struct CalendarDate: View {
    
    @State var isActive: Bool = true
    var dateOpacity: Double
    
    var currentDay: Date
    var date: String
//    var calendarDateString: String
    let formater: DateFormatter = DateFormatter()
    
    init(isActive: Bool, calendarDate: Date = .now) {
        formater.dateFormat = "dd"
        currentDay = calendarDate
        self.date = formater.string(from: calendarDate)
        dateOpacity = isActive ? 1.0 : 0.5
        formater.dateFormat = "dd-MM-yyyy"
        print(isActive)
    }
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Calendar.current.isDateInToday(currentDay) ? .indigo : .white)
                .shadow(radius: 5)
                .frame(width: 45)
            Text(self.date)
                .font(.custom("Roboto", size: 16))
                .bold()
            Circle()
                .fill(.orange)
                .frame(width: 7)
                .padding(.top, 25)
        }
        .opacity(dateOpacity)
    }
}

#Preview {
    HStack{
        CalendarDate(isActive: true, calendarDate: .now)
        CalendarDate(isActive: false, calendarDate: .now)
        CalendarDate(isActive: true, calendarDate: .distantPast)
        CalendarDate(isActive: false, calendarDate: .distantPast)
    }
}
