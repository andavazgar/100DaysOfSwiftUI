//
//  MapContentView.swift
//  BucketList
//
//  Created by Andres Vazquez on 2020-08-14.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct MapContentView: View {
    var body: some View {
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct MapContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapContentView()
    }
}
