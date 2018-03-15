//
//  Stops+CoreDataClass.swift
//  MidTermApp
//
//  Created by Ruth Torres Castillo on 3/15/18.
//  Copyright © 2018 New Mexico State University. All rights reserved.
//
//

import Foundation
import CoreData
import MapKit

@objc(Stops)
public class Stops: NSManagedObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    public var title: String? {
        if (stopDescription?.isEmpty)! {
            return "(No Description)"
        } else {
            return stopDescription
        }
    }
    
    public var subtitle: String? {
        return stopDescription
    }

}
