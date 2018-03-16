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

    @IBOutlet weak var r1Button: UIBarButtonItem!
    @IBOutlet weak var r2Button: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    //one object entity for each route

    var stops = [Stops]()
    var stopsR2 = [StopsR2]()
    var currentRoute = 0
    var routesArray = [MKRoute]()
    var routeColor = UIColor.white
    
    //sets up an observer to the Object for when changes happen
    var managedObjectContext: NSManagedObjectContext! {
        didSet {
            NotificationCenter.default.addObserver(forName: Notification.Name.NSManagedObjectContextObjectsDidChange, object: managedObjectContext, queue: OperationQueue.main) { notification in
                if self.isViewLoaded {
                    self.updateStops(1)
                    self.updateStops(2)
                    self.updateStops(0)
                    //self.updateStops(2)
                    
                }
            }
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<3 {
        updateStops(i)
        }

    }

    
    // MARK:- Actions
    @IBAction func showUser() {
        let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    @IBAction func showLocations() {
        let theRegion = region(for: stops)
        mapView.setRegion(theRegion, animated: true)
    }
    @IBAction func showLocationsR2() {
        let theRegion = region(for: stopsR2)
        mapView.setRegion(theRegion, animated: true)
    }
    
    @IBAction func UndoRoute(){
        //mapView.removeAnnotations(stops as! [MKAnnotation])
        for overlay in mapView.overlays {
            mapView.remove(overlay)
        }
    }
    
    
    @IBAction func GetRoute1(){
        //This is for Route #1
        routeColor = UIColor.green
        for i in 0..<(stops.count-1){
        
            mapView.delegate = self
            let source = stops[i]
            let destination = stops[i+1]
            
            let sourceLocation = CLLocationCoordinate2D(latitude: source.latitude, longitude: source.longitude)
            let destinationLocation = CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude)

            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate {
                (response, error) -> Void in
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    return
                }
               
                let route = response.routes[0]
                
                self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)

                let location = CLLocationCoordinate2D(latitude: 32.305377, longitude: -106.780586)
                let span = MKCoordinateSpanMake(0.03, 0.03)
                let region = MKCoordinateRegion(center: location, span: span)
                self.mapView.setRegion(region, animated: true)
                }
        }
    }
   
    @IBAction func GetRoute2(){
        //This is for Route #1
        routeColor = UIColor.blue
        for i in 0..<(stopsR2.count-1){
            
            mapView.delegate = self
            let source = stopsR2[i]
            let destination = stopsR2[i+1]
            
            let sourceLocation = CLLocationCoordinate2D(latitude: source.latitude, longitude: source.longitude)
            let destinationLocation = CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude)
            
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate {
                (response, error) -> Void in
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    return
                }
                
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            //let rect = route.polyline.boundingMapRect
            //self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            let location = CLLocationCoordinate2D(latitude: 32.305377, longitude: -106.780586)
            let span = MKCoordinateSpanMake(0.03, 0.03)
            let region = MKCoordinateRegion(center: location, span: span)
            self.mapView.setRegion(region, animated: true)
            }
        }
    }
    func drawRoute (_ current: MKRoute)
    {
        self.mapView.add((current.polyline), level: MKOverlayLevel.aboveRoads)
        //let rect = route.polyline.boundingMapRect
        let location = CLLocationCoordinate2D(latitude: 32.326595, longitude: -106.775436)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = routeColor
        renderer.lineWidth = 4.0
        return renderer
    }
 
    func updateStops(_ current: Int){
        
        switch current {
        case 1:
            let entity = Stops.entity()
            let fetchRequest = NSFetchRequest<Stops>()
            fetchRequest.entity = entity
            stops = try! managedObjectContext.fetch(fetchRequest)
            mapView.addAnnotations(stops)
            if !stops.isEmpty {
                showLocations()
            }
          
        case 2:
            let entity = StopsR2.entity()
            let fetchRequest = NSFetchRequest<StopsR2>()
            fetchRequest.entity = entity
            stopsR2 = try! managedObjectContext.fetch(fetchRequest)
            mapView.addAnnotations(stopsR2)
            if !stopsR2.isEmpty {
                showLocationsR2()
            }
          
        default:
            let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
            mapView.setRegion(mapView.regionThatFits(region), animated: true)
        }
    }
    
    func updateStopsR2(){
        //mapView.removeAnnotations(stopsR2 as [MKAnnotation])
        let entity = StopsR2.entity()
        let fetchRequest = NSFetchRequest<StopsR2>()
        fetchRequest.entity = entity
        stopsR2 = try! managedObjectContext.fetch(fetchRequest)
        mapView.addAnnotations(stopsR2)
    }
    func region(for annotations: [MKAnnotation]) -> MKCoordinateRegion {
        let region: MKCoordinateRegion
        
        switch annotations.count {
        case 0:
            region = MKCoordinateRegionMakeWithDistance(
                mapView.userLocation.coordinate, 1000, 1000)
        case 1:
            let annotation = annotations[annotations.count - 1]
            region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000)
            
        default:
            var topLeft = CLLocationCoordinate2D(latitude: -45, longitude: 120)
            var bottomRight = CLLocationCoordinate2D(latitude: 45, longitude: -120)
            
            for annotation in annotations {
                topLeft.latitude = max(topLeft.latitude, annotation.coordinate.latitude)
                topLeft.longitude = min(topLeft.longitude, annotation.coordinate.longitude)
                bottomRight.latitude = min(bottomRight.latitude, annotation.coordinate.latitude)
                bottomRight.longitude = max(bottomRight.longitude, annotation.coordinate.longitude)
            }
            
            let center = CLLocationCoordinate2D(latitude: topLeft.latitude - (topLeft.latitude - bottomRight.latitude) / 2, longitude: topLeft.longitude - (topLeft.longitude - bottomRight.longitude) / 2)
            
            let extraSpace = 2.0
            let span = MKCoordinateSpan(latitudeDelta: abs(topLeft.latitude - bottomRight.latitude) * extraSpace, longitudeDelta: abs(topLeft.longitude - bottomRight.longitude) * extraSpace)
            region = MKCoordinateRegion(center: center, span: span)
            
            /*let location = CLLocationCoordinate2D(latitude: 32.305377, longitude: -106.780586)
            let span = MKCoordinateSpanMake(0.03, 0.03)
            region = MKCoordinateRegion(center: location, span: span)*/
        }
        
        return mapView.regionThatFits(region)
    }
    
    @objc func showStopDetails(_ sender: UIButton) {
        performSegue(withIdentifier: "EditLocation", sender: sender)
    }
}
   
   
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch currentRoute {
        case 1:
            guard annotation is (Stops) else {
                return nil
            }
            let identifier = "stops"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                pinView.isEnabled = true
                pinView.canShowCallout = true
                pinView.animatesDrop = false
                pinView.pinTintColor = UIColor(red: 0.0, green: 0.82, blue: 0.4, alpha: 1)
                let rightButton = UIButton(type: .detailDisclosure)
                rightButton.addTarget(self, action: #selector(showStopDetails), for: .touchUpInside)
                pinView.rightCalloutAccessoryView = rightButton
                annotationView = pinView
            }
            if let annotationView = annotationView {
                annotationView.annotation = annotation
                let button = annotationView.rightCalloutAccessoryView as! UIButton
                if let index = stops.index(of: annotation as! Stops) {
                    button.tag = index
                }
            }
            return annotationView
        case 2:
            guard annotation is (StopsR2) else {
                return nil
            }
            let identifier = "stopsR2"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                pinView.isEnabled = true
                pinView.canShowCallout = true
                pinView.animatesDrop = false
                pinView.pinTintColor = UIColor(red: 0.0, green: 0.0, blue: 0.8, alpha: 1)
                let rightButton = UIButton(type: .detailDisclosure)
                rightButton.addTarget(self, action: #selector(showStopDetails), for: .touchUpInside)
                pinView.rightCalloutAccessoryView = rightButton
                annotationView = pinView
            }
            if let annotationView = annotationView {
                annotationView.annotation = annotation
                let button = annotationView.rightCalloutAccessoryView as! UIButton
                if let index = stopsR2.index(of: annotation as! StopsR2) {
                    button.tag = index
                }
            }
            return annotationView
        default:
            let identifier = "stops"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            return annotationView
        }
       
    }
    
    
}
