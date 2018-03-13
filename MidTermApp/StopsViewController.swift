//
//  StopsViewController.swift
//  MidTermApp
//
//  Created by Ruth Torres Castillo on 3/12/18.
//  Copyright © 2018 New Mexico State University. All rights reserved.
//

import Foundation
import UIKit

class StopsViewController: UITableViewController, XMLParserDelegate {
    var stops: [Stop] = []
    var eName: String = String()
    var stopLatitude = String()
    var stopLongitude = String()
    var stopDescription = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.url(forResource: "stopsR1", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                let success:Bool = parser.parse()
                if success {
                    print("success")
                } else {
                    print("parse failure!")
                }
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopCell", for: indexPath)
        
        let stop = stops[indexPath.row]
        
        cell.textLabel?.text = stop.stopDescription
        cell.detailTextLabel?.text = "Latitude: " + stop.stopLatitude + " Longitude: " + stop.stopLongitude
        //let imageName = UIImage(named: route.stopLongitude)
        //cell.imageView?.image = imageName
        
        return cell
    }
    
    
    // MARK: - XML Parser Delegates
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        if elementName == "stop" {
            stopLatitude = String()
            stopLongitude = String()
            stopDescription = String()
        }
    }
    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "stop" {
            
            let stop = Stop()
            stop.stopLatitude = stopLatitude
            stop.stopLongitude = stopLongitude
            stop.stopDescription = stopDescription
            stops.append(stop)
        }
    }
    
    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if eName == "latitude" {
                stopLatitude += data
            } else if eName == "longitude" {
                stopLongitude += data
            } else if eName == "description" {
                stopDescription += data
            }
        }
    }
    
   
    
    
}
