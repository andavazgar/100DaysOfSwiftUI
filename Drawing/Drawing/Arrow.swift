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
        let insettedRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        var path = Path()
        path.addLines([
            CGPoint(x: insettedRect.minX, y: insettedRect.midY * 0.9),
            CGPoint(x: insettedRect.maxX * 0.65, y: insettedRect.midY * 0.9),
            CGPoint(x: insettedRect.maxX * 0.60, y: insettedRect.midY * 0.75),
            CGPoint(x: insettedRect.maxX, y: insettedRect.midY),
            CGPoint(x: insettedRect.maxX * 0.60, y: insettedRect.midY * 1.25),
            CGPoint(x: insettedRect.maxX * 0.65, y: insettedRect.midY * 1.1),
            CGPoint(x: insettedRect.minX, y: insettedRect.midY * 1.1),
            CGPoint(x: insettedRect.minX, y: insettedRect.midY * 0.9)
        ])
        path.closeSubpath()
        
        return path.rotation(.degrees(-direction.degrees)).path(in: insettedRect)
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
