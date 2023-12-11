//
//  CalendarDateRow.swift
//  Calendar
//
//  Created by Владислав Лесовой on 11.12.2023.
//

import SwiftUI

struct CalendarDateRow: View {
    
    let formater: DateFormatter = DateFormatter()
    @State var day: Int = 0
    var stringDate: String {get{String(day)}}
    @ObservedObject var CalendVM: CalendarVM = CalendarVM()
    
    init() {
        print(Date().startOfMonth.description(with: .current))
        formater.dateFormat = "dd-MM-yyyy"
        print(Calendar.current.component(.weekday, from: formater.date(from: "04-12-2023")!))
        print(Calendar.current.component(.weekday, from: formater.date(from: "05-12-2023")!))
        print(Calendar.current.component(.weekday, from: formater.date(from: "06-12-2023")!))
        print(Calendar.current.component(.weekday, from: formater.date(from: "07-12-2023")!))
        print(Calendar.current.component(.weekday, from: formater.date(from: "08-12-2023")!))
        print(Calendar.current.component(.weekday, from: formater.date(from: "09-12-2023")!))
        print(Calendar.current.component(.weekday, from: formater.date(from: "10-12-2023")!))
//        print(CalendVM.days)
    }
    
    var body: some View {
        Text(String(CalendVM.startDayOfWeek))
        Text(String(CalendVM.currentYear))
        Text(String(CalendVM.currentMonth))
        Button(action: {CalendVM.nextMonth()}, label: {Text("Next")})
        Button(action: {CalendVM.previousMonth()}, label: {Text("Previous")})
        HStack(spacing: 32){
            Text("Пн")
            Text("Вт")
            Text("Ср")
            Text("Чт")
            Text("Пт")
            Text("Сб")
            Text("Вс")
        }
        HStack{
            VStack{
                ForEach(CalendVM.days, id: \.hashValue){ days in
                    HStack{
                        ForEach(days, id: \.hashValue){ i in
                            CalendarDate(isActive: true, calendarDate: formater.date(from: i)!)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarDateRow()
}
