//
//  CalendarDate.swift
//  Calendar
//
//  Created by Владислав Лесовой on 11.12.2023.
//

import SwiftUI

struct CalendarDate: View {
    
    @State var isActive: Bool = true
    @State var dateOpacity: Double = 1.0
    
    var currentDay: Date = .now
    var date: String
    
    let formater: DateFormatter = DateFormatter()
    
    init(isActive: Bool, calendarDate: Date = .now) {
        formater.dateFormat = "dd"
        self.date = formater.string(from: calendarDate)
        self.isActive = isActive
    }
    
    var body: some View {
        ZStack{
            Circle()
                .fill(.white)
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
    private func activate() -> Void{
        withAnimation(.easeIn(duration: 0.1), {self.dateOpacity = self.dateOpacity == 0.5 ? 1 : 0.5})
    }
//    private func currentDay() -> Void{
//        
//    }
}

#Preview {
    CalendarDate(isActive: true, calendarDate: .now)
}
