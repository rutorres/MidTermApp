//
//  RoutesViewController.swift
//  Routes
//
//  Created by Ruth Torres Castillo on 3/10/18.
//  Copyright © 2018 New Mexico State University. All rights reserved.
//

import UIKit

class RoutesViewController: UITableViewController, XMLParserDelegate {
    var routes: [Route] = []
    var eName: String = String()
    var routeName = String()
    var routeColor = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.url(forResource: "routes", withExtension: "xml") {
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
        return routes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath)
        
        let route = routes[indexPath.row]
        
        cell.textLabel?.text = route.routeName
        cell.detailTextLabel?.text = route.routeColor
        let imageName = UIImage(named: route.routeColor)
        cell.imageView?.image = imageName
        
        return cell
    }


    // MARK: - XML Parser Delegates
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        if elementName == "route" {
            routeName = String()
            routeColor = String()
        }
    }
    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "route" {
            
            let route = Route()
            route.routeName = routeName
            route.routeColor = routeColor
            print(route)
            routes.append(route)
        }
    }
    
    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if eName == "name" {
                routeName += data
            } else if eName == "color" {
                routeColor += data
            }
        }
    }
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PDF" {
            let controller = segue.destination as! PDFDisplayViewController
            controller.route = 1
        }
    }
 

}
