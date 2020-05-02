//
//  Arrow.swift
//  Drawing
//
//  Created by Andres Vazquez on 2020-05-01.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {
    var direction: Angle = .degrees(0)
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLines([
            CGPoint(x: rect.maxX * 0.60, y: rect.midY * 0.8),
            CGPoint(x: rect.maxX * 0.75, y: rect.midY),
            CGPoint(x: rect.maxX * 0.60, y: rect.midY * 1.2),
            CGPoint(x: rect.maxX, y: rect.midY)
        ])
        
        path.addRect(CGRect(x: rect.minX, y: rect.midY * 0.9, width: rect.width * 0.75, height: rect.height * 0.1))
        
        path = path.applying(CGAffineTransform(rotationAngle: CGFloat.pi))
        
        return path
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        Arrow(direction: .degrees(90))
            .fill(Color.blue)
    }
}
