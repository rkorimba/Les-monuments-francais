//
//  CarteController.swift
//  Les monuments français
//
//  Created by Riad Korimbacus on 23/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CarteController: UIViewController {

    @IBOutlet weak var carte: MKMapView!
    @IBOutlet weak var maPositionBouton: UIButton!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var urlString = "https://www.data.gouv.fr/s/resources/monuments-historiques-francais/20150408-163911/monuments.json"
    var locationManager = CLLocationManager()
    var monuments = [Monument]()
    let codeur = CLGeocoder()
    
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
                DispatchQueue.main.async {
                    self.obtenirAnnotations()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func obtenirAnnotations() {
        
        for monument in self.monuments {
            if let latitudeString = monument.latitude, let longitudeString = monument.longitude {
                if let latitude = Double(latitudeString), let longitude = Double(longitudeString) {
                    let coordonnes = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let titre = monument.name ?? ""
                    let location = CLLocation(latitude: latitude, longitude: longitude)
                    var adresse = ""
                    codeur.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                        if let erreur = error {
                            print("Pas d'adresse -> " + erreur.localizedDescription)
                        } else if let array = placemarks, array.count > 0 {
                            let monPositionnement = array.last
                            let numero = monPositionnement?.subThoroughfare ?? ""
                            let rue = monPositionnement?.thoroughfare ?? ""
                            let ville = monPositionnement?.locality ?? ""
                            adresse = numero + " " + rue + ", " + ville
                        }
                        let monAnnotation = MonAnnotation(title: titre, adresse: adresse, coordonnes: coordonnes)
                        self.carte.addAnnotation(monAnnotation)
                    })
                    
                }
            }
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(monument.latitude!)!, longitude: Double(monument.longitude!)!)
            annotation.title = monument.name ?? "Pas de nom"
            self.carte.addAnnotation(annotation)
        }
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
