//
//  ContentView.swift
//  Better Rest
//
//  Created by Oritsegbe T. Nanna on 10/27/19.
//  Copyright © 2019 Oritsegbe T.  Nanna. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    let model = SleepCalculator()
    
    var wakeTime: String {
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
            
            } catch {
                
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Text("When do you want to wakeup?")
                    .font(.headline)
                
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                
                Section {
                    
                    Text("Desired amount of sleep").font(.headline)
                    
                    Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                Section {
                    HStack {
                        Text("Daily coffee intake")
                            .font(.headline)
                        
                        Picker("Daily coffee intake", selection: $coffeeAmount) {
                            ForEach(1 ... 20, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 80, height: 200)
                        
                        Text(coffeeAmount == 1 ? "Cup" : "Cups")
                    }
                }
            }
            .navigationBarTitle("BetterRest   @\(wakeTime)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
