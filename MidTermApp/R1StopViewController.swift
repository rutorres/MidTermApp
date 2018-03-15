//
//  R1StopViewController.swift
//  MidTermApp
//
//  Created by Ruth Torres Castillo on 3/15/18.
//  Copyright © 2018 New Mexico State University. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

class R1StopViewController: UITableViewController {
    var managedObjectContext: NSManagedObjectContext!
    var stops = [Stops]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let fetchRequest = NSFetchRequest<Stops>()
        let entity = Stops.entity()
        fetchRequest.entity = entity
        let sortDescriptor = NSSortDescriptor(key: "latitude",
                                              ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do{
            stops = try managedObjectContext.fetch(fetchRequest)
        } catch {
            //NSCoreDataError(error)
            print(error)
        }
    }
    //MARK: - Table view delegates
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return stops.count
        return stops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopCell", for: indexPath)
        
        let rstop = stops[indexPath.row]
        
        cell.textLabel?.text = rstop.stopDescription
        cell.detailTextLabel?.text = rstop.direction
        //let imageName = UIImage(named: route.stopLongitude)
        //cell.imageView?.image = imageName
        
        return cell
    }
    
}
