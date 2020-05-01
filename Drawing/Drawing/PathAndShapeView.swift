//
//  PathAndShapeView.swift
//  Drawing
//
//  Created by Andres Vazquez on 2020-04-30.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct PathAndShapeView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 70) {
                Path { path in
                    path.move(to: CGPoint(x: 210, y: 100))
                    path.addLine(to: CGPoint(x: 110, y: 300))
                    path.addLine(to: CGPoint(x: 310, y: 300))
                    path.addLine(to: CGPoint(x: 210, y: 100))
                }
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                
                Triangle()
                .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .frame(width: 200, height: 200)
                
                Arc(startAngle: .degrees(0), endAngle: .degrees(150), clockwise: false)
                    .strokeBorder(Color.red, lineWidth: 10)
                    .frame(width: 200, height: 200)
            }
            
            VStack(spacing: 220) {
                Text("Path")
                Text("Triangle\n(Shape)")
                VStack {
                    Text("Arc 0 → 150")
                    Text("(Shape)")
                }
            }
            .font(.headline)
            .foregroundColor(Color(.darkGray))
            .offset(x: 0, y: 60)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: startAngle, endAngle: -endAngle, clockwise: !clockwise)
        return path
    }
    
    func inset(by amount: CGFloat) -> Arc {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct PathAndShapeView_Previews: PreviewProvider {
    static var previews: some View {
        PathAndShapeView()
    }
}
