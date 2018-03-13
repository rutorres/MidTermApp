//
//  MapViewController.swift
//  MidTermApp
//
//  Created by Ruth Torres Castillo on 3/12/18.
//  Copyright © 2018 New Mexico State University. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var managedObjectContext: NSManagedObjectContext!
    
    // MARK:- Actions
    @IBAction func showUser() {
        let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    @IBAction func showLocations() {
       
    }
}
   
   
extension MapViewController: MKMapViewDelegate {
    
}

