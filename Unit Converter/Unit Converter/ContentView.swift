//
//  ContentView.swift
//  Unit Converter
//
//  Created by Andres Vazquez on 2020-03-25.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State var selectedCategoryIndex = 0
    @State private var inputValue = ""
    @State private var inputUnitIndex = 0
    @State private var outputUnitIndex = 0
    
    var unitsForCategory: [Dimension] {
        return ConversionUnit.allCases[selectedCategoryIndex].units()
    }
    var inputUnit: Dimension {
        let units = ConversionUnit.allCases[selectedCategoryIndex].units()
        return units[inputUnitIndex]
    }
    var outputUnit: Dimension {
        let units = ConversionUnit.allCases[selectedCategoryIndex].units()
        return units[outputUnitIndex]
    }

    private var result: Double {
        let value = Double(inputValue) ?? 0
        let inputMeasurement = Measurement(value: value, unit: inputUnit)

        return inputMeasurement.converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit Type", selection: $selectedCategoryIndex) {
                        ForEach(0 ..< ConversionUnit.allCases.count, id: \.self) {
                            Text("\(ConversionUnit.allCases[$0].rawValue)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Picker("Input Unit", selection: $inputUnitIndex) {
                        ForEach(0 ..< unitsForCategory.count, id: \.self) {
                            Text("\(self.unitsForCategory[$0].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    HStack {
                        TextField("", text: $inputValue)
                            .multilineTextAlignment(.trailing)
                        Text(inputUnit.symbol)
                    }
                }

                Section {
                    Picker("Output Unit", selection: $outputUnitIndex) {
                        ForEach(0 ..< unitsForCategory.count, id: \.self) {
                            Text("\(self.unitsForCategory[$0].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    HStack {
                        Spacer()
                        Text("\(result, specifier: "%g")")
                        Text(outputUnit.symbol)
                    }
                }
            }
            .navigationBarTitle("Unit Converter")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
