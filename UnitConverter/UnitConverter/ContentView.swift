//
//  ContentView.swift
//  UnitConverter
//
//  Created by Andres Vazquez on 2020-03-25.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var selectedCategoryIndex = 0
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

    private var result: String {
        var result = ""
        if let value = Double(inputValue) {
            let inputMeasurement = Measurement(value: value, unit: inputUnit)
            let conversionResult = inputMeasurement.converted(to: outputUnit).value
            let numFormatter = NumberFormatter()
            numFormatter.maximumFractionDigits = 2
            
            result = numFormatter.string(from: NSNumber(value: conversionResult)) ?? ""
        }
        
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit Type", selection: Binding(get: {
                        self.selectedCategoryIndex
                    }, set: { newCategory in
                        self.selectedCategoryIndex = newCategory
                        
                        // Reset inputUnitIndex and outputUnitIndex to avoid index out of range crash
                        self.inputUnitIndex = 0
                        self.outputUnitIndex = 0
                    })) {
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
                            .keyboardType(.decimalPad)
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
                        Text("\(result)")
                        Text(outputUnit.symbol)
                    }
                }
                
                if inputUnitIndex != outputUnitIndex {
                    Section {
                        Button("Switch: \(outputUnit.symbol) → \(inputUnit.symbol)") {
                            let temp = self.inputUnitIndex
                            self.inputUnitIndex = self.outputUnitIndex
                            self.outputUnitIndex = temp
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationBarTitle("Unit Converter")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .colorScheme(.dark)
        }
    }
}
