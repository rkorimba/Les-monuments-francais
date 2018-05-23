//
//  MonAnnotation.swift
//  Les monuments français
//
//  Created by Riad Korimbacus on 23/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import MapKit

class MonAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    let image = #imageLiteral(resourceName: "Group")
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, adresse: String, coordonnes: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = adresse
        self.coordinate = coordonnes
        super.init()
    }
    
}
