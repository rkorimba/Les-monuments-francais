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
    
    var urlString = "https://www.data.gouv.fr/s/resources/monuments-historiques-francais/20150408-163911/monuments.json"
    var locationManager = CLLocationManager()
    var monuments = [Monument]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carte.showsUserLocation = true
        miseEnPlace()
        obtenirDonneesDepuisJSON()
    }
   
    func obtenirDonneesDepuisJSON() {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard data != nil else { return }
            do {
                self.monuments = try JSONDecoder().decode([Monument].self, from: data!)
                for monument in self.monuments {
                    print(monument.name)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
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
