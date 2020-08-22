//
//  ContentView.swift
//  BetterRest
//
//  Created by Andres Vazquez on 2020-03-31.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    var bedtime: String {
        calculateBedtime()
    }
    var accessibleSleepAmount: String {
        let hours = floor(sleepAmount)
        
        if sleepAmount == hours {
            return "\(Int(hours)) hours"
        }
        
        return "\(Int(hours)) hours and \(Int((sleepAmount - hours) * 60)) minutes"
    }
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    Stepper("\(sleepAmount, specifier: "%g") hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .accessibility(label: Text(""))
                        .accessibility(value: Text(accessibleSleepAmount))
                }
                
                Section(header: Text("Daily coffee intake")) {
                    Stepper(value: $coffeeAmount, in: 1...20) {
                        if coffeeAmount == 1 {
                            Text("1 cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
                        .accessibility(label: Text(""))
                    .accessibility(value: Text(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups"))
                }
                
                Section(header: Text("Your ideal bedtime is...").accessibility(hidden: true)) {
                    Text(bedtime)
                        .font(.headline)
                }
                .accessibility(label: Text("Your ideal bedtime is \(bedtime)"))
            }
            .navigationBarTitle("BetterRest")
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }
    
    private func calculateBedtime() -> String {
        var bedtime = ""
        let model = SleepCalculator()
        
        let wakeTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hoursInSeconds = (wakeTimeComponents.hour ?? 0) * 60 * 60
        let minutesInSeconds = (wakeTimeComponents.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hoursInSeconds + minutesInSeconds), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let bedtimeDate = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            bedtime = formatter.string(from: bedtimeDate)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showAlert = true
        }
        
        return bedtime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
