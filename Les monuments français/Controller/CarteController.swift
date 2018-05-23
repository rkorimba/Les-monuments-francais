//
//  CarteController.swift
//  Les monuments français
//
//  Created by Riad Korimbacus on 23/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import MapKit

class CarteController: UIViewController {

    @IBOutlet weak var carte: MKMapView!
    @IBOutlet weak var maPositionBouton: UIButton!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carte.showsUserLocation = true
        miseEnPlace()
    }
   
    @IBAction func meLocaliser(_ sender: Any) {
    
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
   
    @IBAction func segmentChoisi(_ sender: Any) {
       
        switch segment.selectedSegmentIndex {
        case 0: carte.mapType = .standard
        case 1: carte.mapType = .satellite
        case 2: carte.mapType = .hybrid
        default: break
        }
    }

}
