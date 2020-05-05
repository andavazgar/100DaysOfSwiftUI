//
//  ImagePaintView.swift
//  Drawing
//
//  Created by Andres Vazquez on 2020-05-04.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ImagePaintView: View {
    var body: some View {
        Capsule()
            .strokeBorder(ImagePaint(image: Image("Swift"), scale: 0.05), lineWidth: 30)
            .frame(width: 300, height: 200)
    }
}

struct ImagePaintView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaintView()
    }
}
