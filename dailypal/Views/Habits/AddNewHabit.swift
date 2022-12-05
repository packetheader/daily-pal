//
//  AddNewHabit.swift
//  dailypal
//
//  Created by Tobias Bartz on 05.12.22.
//

import SwiftUI

struct AddNewHabit: View {
    @EnvironmentObject var habitModel: HabitViewModel
    var body: some View {
        NavigationView{
            VStack(spacing: 15) {
                TextField("Title", text: $habitModel.title)
                    .padding(.horizontal)
                    .padding(.vertical,10)
                    .background(Color(.systemGray5),in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                
                HStack(spacing: 0) {
                    ForEach(1...6,id: \.self){index in
                        let color = "Card-\(index)"
                        Circle()
                            .fill(Color(color))
                            .frame(width: 30, height: 30)
                            .frame(maxWidth: .infinity)
                            .overlay(content: {
                                if color == habitModel.habitColor{
                                    Image(systemName: "checkmark")
                                        .font(.caption.bold())
                                }
                            })
                            .onTapGesture {
                                withAnimation{
                                    habitModel.habitColor = color
                                }
                            }
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Frequency")
                        .font(.callout.bold())
                    let weekDays = Calendar.current.weekdaySymbols
                    HStack(spacing: 10) {
                        ForEach(weekDays,id: \.self){day in
                            let index = habitModel.weekDays.firstIndex {value in
                                return value == day
                            } ?? -1
                            Text(day.prefix(2))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical,12)
                                .fontWeight(.semibold)
                                .background{
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(index != -1 ? Color(habitModel.habitColor) : Color(.systemGray5).opacity(0.4))
                                }
                                .onTapGesture {
                                    withAnimation{
                                        if index != -1 {
                                            habitModel.weekDays.remove(at: index)
                                        } else {
                                            habitModel.weekDays.append(day)
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.top, 15)
                }
                
                Divider()
                    .padding(.vertical,10)
                
                HStack{
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Remainder")
                            .fontWeight(.semibold)
                        
                        Text("Just notification")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Toggle(isOn: $habitModel.isRemainderOn) {}
                        .labelsHidden()
                }
                
                HStack(spacing: 12){
                    Label {
                        Text(habitModel.remainderDate.formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .padding(.horizontal)
                    .padding(.vertical,12)
                    .background(Color(.systemGray5).opacity(0.4),in:
                                    RoundedRectangle(cornerRadius: 6, style: .continuous))
                    
                    
                    TextField("Remainder Text", text: $habitModel.remainderText)
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .background(Color(.systemGray5),in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                }
                .frame(height: habitModel.isRemainderOn ? nil : 0)
                .opacity(habitModel.isRemainderOn ? 1 : 0)
            }
            .animation(.easeInOut, value: habitModel.isRemainderOn)
            .frame(maxHeight: .infinity,alignment: .top)
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Add Habit")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                    .tint(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        
                    }
                    .tint(.white)
                }
            }
        }
    }
}

struct AddNewHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHabit()
            .environmentObject(HabitViewModel())
            .preferredColorScheme(.dark)
    }
}
