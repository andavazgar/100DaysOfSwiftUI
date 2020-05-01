//
//  FlowerView.swift
//  Drawing
//
//  Created by Andres Vazquez on 2020-04-30.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct FlowerView: View {
    @State private var petalOffset: CGFloat = -20.0
    @State private var petalWidth: CGFloat = 100.0
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct Flower: Shape {
    var petalOffset: CGFloat = -20.0
    var petalWidth: CGFloat = 100.0
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
        
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let translation = CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2)
            let position = rotation.concatenating(translation)
            
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerView()
    }
}
