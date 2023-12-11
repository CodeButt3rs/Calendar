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
    @State var selectedYear: String = "2023"
    init() {
        formater.dateFormat = "dd-MM-yyyy"
    }
    
    var body: some View {
        Button(action: {CalendVM.goBack()}, label:{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(radius: 3)
                    .frame(width: 370, height: 40)
                HStack(){
                    Image(systemName: "arrowshape.forward.circle")
                        .rotationEffect(.degrees(180))
                    Text("Go back")
                        .font(.custom("Roboto Bold", size: 18))
                        .padding(.horizontal)
                    Image(systemName: "arrowshape.forward.circle")
                        .rotationEffect(.degrees(180))
                }
                .frame(minWidth: 180, minHeight: 40)
            }
        })
        Picker("Год", selection: $selectedYear){
            ForEach(1...2100, id: \.description){ i in
                Text(String(i))
            }
        }
        .onChange(of: selectedYear) {
            CalendVM.setYear(year: Int(selectedYear)!)
        }
        Text(String("Я календарь переверну, и снова..."))
            .fontWeight(.bold)
        HStack{
            Button(action: {CalendVM.previousYear()}, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .shadow(radius: 3)
                        .frame(width: 180, height: 40)
                    HStack(){
                        Image(systemName: "arrowshape.forward.circle")
                            .rotationEffect(.degrees(180))
                        Text(String(CalendVM.currentYear - 1))
                            .font(.custom("Roboto Bold", size: 18))
                            .padding(.leading)
                    }
                    .frame(minWidth: 180, minHeight: 40)
                }
            })
            Button(action: {CalendVM.nextYear()}, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .shadow(radius: 3)
                        .frame(width: 180, height: 40)
                    HStack(){
                        Text(String(CalendVM.currentYear + 1))
                            .font(.custom("Roboto Bold", size: 18))
                            .padding(.trailing)
                        Image(systemName: "arrowshape.forward.circle")
                    }
                    .frame(minWidth: 180, minHeight: 40)
                }
            })
        }
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(radius: 3)
                .frame(width: 370, height: 40)
            Text(String(CalendVM.currentYear))
                .font(.custom("Roboto Bold", size: 24))
        }
        HStack{
            Button(action: {CalendVM.previousMonth()}, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .shadow(radius: 3)
                        .frame(width: 180, height: 40)
                    HStack(){
                        Image(systemName: "arrowshape.forward.circle")
                            .rotationEffect(.degrees(180))
                        Text(CalendarVM.months[CalendVM.getMonth(much: -1)])
                            .font(.custom("Roboto Bold", size: 18))
                            .padding(.leading)
                    }
                    .frame(minWidth: 180, minHeight: 40)
                }
            })
            Button(action: {CalendVM.nextMonth()}, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .shadow(radius: 3)
                        .frame(width: 180, height: 40)
                    HStack(){
                        Text(CalendarVM.months[CalendVM.getMonth(much: 1)])
                            .font(.custom("Roboto Bold", size: 18))
                            .padding(.trailing)
                        Image(systemName: "arrowshape.forward.circle")
                    }
                    .frame(minWidth: 180, minHeight: 40)
                }
            })
        }
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(radius: 3)
                .frame(width: 370, height: 40)
            Text(CalendarVM.months[CalendVM.currentMonth])
                .font(.custom("Roboto Bold", size: 24))
        }
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
                        ForEach(days, id: \.id){ i in
                            CalendarDate(isActive: i.activeDay, calendarDate: formater.date(from: i.dayString)!)
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
