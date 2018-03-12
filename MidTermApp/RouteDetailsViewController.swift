//
//  RouteDetailsViewController.swift
//  MidTermApp
//
//  Created by Ruth Torres Castillo on 3/12/18.
//  Copyright © 2018 New Mexico State University. All rights reserved.
//

import Foundation
import UIKit

class RouteDetailsViewController: UIViewController {

    //MARK:- Actions
    @IBAction func done(){
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancel(){
        navigationController?.popViewController(animated: true)
    }

}

