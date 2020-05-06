//
//  BlendModesView.swift
//  Drawing
//
//  Created by Andres Vazquez on 2020-05-05.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct BlendModesView: View {
    @State private var amount: CGFloat = 0.5
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
                
                
            }
            .frame(width: 300, height: 300)
            
            Image("Swift")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .saturation(Double(amount))
            .blur(radius: (1 - amount) * 10)
                .padding(.bottom, 20)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MultiplyView: View {
    var body: some View {
        Image("Swift")
            .resizable()
            .frame(width: 300, height: 300)
            .scaledToFit()
            .colorMultiply(.purple)
    }
}

struct BlendModesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MultiplyView()
            BlendModesView()
        }
    }
}
