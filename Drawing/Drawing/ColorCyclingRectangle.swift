//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by Andres Vazquez on 2020-05-06.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var gradient: (startPoint: UnitPoint, endPoint: UnitPoint) = (.top, .bottom)
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: self.gradient.startPoint, endPoint: self.gradient.endPoint), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    private func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangle(gradient: (startPoint: .leading, endPoint: .trailing))
    }
}
