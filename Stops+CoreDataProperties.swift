//
//  Stops+CoreDataProperties.swift
//  MidTermApp
//
//  Created by Ruth Torres Castillo on 3/15/18.
//  Copyright © 2018 New Mexico State University. All rights reserved.
//
//
import CoreLocation
import Foundation
import CoreData


extension Stops {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stops> {
        return NSFetchRequest<Stops>(entityName: "Stops")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var placemark: CLPlacemark?
    @NSManaged public var route: Int16
    @NSManaged public var direction: String?
    @NSManaged public var stopDescription: String?

}
