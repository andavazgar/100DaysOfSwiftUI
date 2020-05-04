//
//  Arrow.swift
//  Drawing
//
//  Created by Andres Vazquez on 2020-05-01.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct Arrow: InsettableShape {
    var direction: Angle = .degrees(0)
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY * 0.95))
        path.addLine(to: CGPoint(x: rect.maxX * 0.60, y: rect.midY * 0.95))
        path.addLine(to: CGPoint(x: rect.maxX * 0.60, y: rect.midY * 0.75))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.60, y: rect.midY * 1.3))
        path.addLine(to: CGPoint(x: rect.maxX * 0.60, y: rect.midY * 1.1))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 1.1))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 0.95))
        
        return path
    }
    
    func inset(by amount: CGFloat) -> Arrow {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        Arrow(direction: .degrees(90))
            .strokeBorder(Color.blue, lineWidth: 5)
    }
}
