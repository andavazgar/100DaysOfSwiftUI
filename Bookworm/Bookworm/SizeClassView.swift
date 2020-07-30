//
//  SizeClassView.swift
//  Bookworm
//
//  Created by Andres Vazquez on 2020-07-29.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct SizeClassView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        if sizeClass == .compact {
            return AnyView(VStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
    }
}

struct SizeClassView_Previews: PreviewProvider {
    static var previews: some View {
        SizeClassView()
    }
}
