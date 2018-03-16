//
//  StopsR2+CoreDataProperties.swift
//  MidTermApp
//
//  Created by Ruth Torres Castillo on 3/15/18.
//  Copyright © 2018 New Mexico State University. All rights reserved.
//
//

import CoreLocation
import Foundation
import CoreData


extension StopsR2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StopsR2> {
        return NSFetchRequest<StopsR2>(entityName: "StopsR2")
    }

    @NSManaged public var stopNumber: Int16
    @NSManaged public var stopDescription: String?
    @NSManaged public var routeID: Int16
    @NSManaged public var placemark: NSObject?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var direction: String?

}
