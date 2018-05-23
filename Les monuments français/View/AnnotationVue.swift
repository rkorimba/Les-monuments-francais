//
//  AnnotationVue.swift
//  Les monuments français
//
//  Created by Riad Korimbacus on 23/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import MapKit

class AnnotationVue: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let nouvelle = newValue as? MonAnnotation else { return }
            image = #imageLiteral(resourceName: "Group")
        }
    }
}
