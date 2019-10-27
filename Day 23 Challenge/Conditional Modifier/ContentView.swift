//
//  ContentView.swift
//  Project 1 Day 16 -18 We Split
//
//  Created by Oritsegbe T. Nanna on 10/25/19.
//  Copyright © 2019 Oritsegbe T.  Nanna. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = ["10", "15", "20", "25", "0"]
    
    var totalPerPerson: Double {
        var amountPerPerson: Double = 0
        let peopleCount = Double(numberOfPeople) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])!
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount * ( tipSelection / 100 )
        let grandTotal = orderAmount + tipValue
        let amountPerPersonTemp = grandTotal / peopleCount
        if amountPerPersonTemp < 0 || amountPerPersonTemp == ( 1 / 0 ) {
            amountPerPerson = 0
        } else {
            amountPerPerson = amountPerPersonTemp
        }
        
        return amountPerPerson
    }
    
    var orderTotal: Double {
        
        var grandTotal1: Double = 0
        let peopleCount1 = Double(numberOfPeople) ?? 0
        let tipSelection1 = Double(tipPercentages[tipPercentage])!
        let orderAmount1 = Double(checkAmount) ?? 0
        
        let tipValue1 = orderAmount1 * ( tipSelection1 / 100 )
        let grandTotalTemp1 = orderAmount1 + tipValue1
 
        if grandTotalTemp1 > 0 {
            grandTotal1 = grandTotalTemp1
        } else {
            grandTotal1 = 0
        }
        
        if peopleCount1 == 0 {
            grandTotal1 = 0
        }
        return grandTotal1
    }
    
    
    
    var body: some View {
            NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
                }
                Section {
                    TextField("Number of People", text: $numberOfPeople).keyboardType(.decimalPad)
                }
                
                Section (header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total check amount")) {
                    Text("$\(orderTotal, specifier: "%.2f")")
                        .foregroundColor(tipPercentage == 4 ? .red : .black)
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
