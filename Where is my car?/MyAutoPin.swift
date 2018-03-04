//
//  MyAutoPin.swift
//  Where is my car?
//
//  Created by Student on 03.01.2018.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import MapKit

class MyAutoPin: NSObject, MKAnnotation {
    let title: String?
    let coordinate : CLLocationCoordinate2D
    var region: CLCircularRegion?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
}
