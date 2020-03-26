//
//  InputUnit.swift
//  UnitConverter
//
//  Created by Andres Vazquez on 2020-03-25.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

extension UnitDuration {
    class var days: UnitDuration {
        let unitConverter = UnitConverterLinear(coefficient: 86400)
        
        return UnitDuration(symbol: "day", converter: unitConverter)
    }
}

enum ConversionUnit: String, CaseIterable {
    case Temperature = "Temperature"
    case Length = "Length"
    case Time = "Time"
    case Volume = "Volume"
    
    func units() -> [Dimension] {
        switch self {
        case .Temperature:
            return [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
        case .Length:
            return [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]
        case .Time:
            return [UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours, UnitDuration.days]
        case .Volume:
            return [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]
        }
    }
    
    static func getInputUnit(for string: String) -> ConversionUnit {
        switch string {
        case "Temperature":
            return ConversionUnit.Temperature
        case "Length":
            return ConversionUnit.Temperature
        case "Time":
            return ConversionUnit.Temperature
        default:
            return ConversionUnit.Volume
        }
    }
}
