//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Andres Vazquez on 2020-08-17.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    var titleValue: String {
        get {
            title ?? ""
        }
        set {
            title = newValue
        }
    }
    
    var subtitleValue: String {
        get {
            subtitle ?? ""
        }
        set {
            subtitle = newValue
        }
    }
}
