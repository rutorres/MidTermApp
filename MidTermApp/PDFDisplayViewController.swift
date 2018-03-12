//
//  PDFDisplayViewController.swift
//  MidTermApp
//
//  Created by Ruth Torres Castillo on 3/12/18.
//  Copyright © 2018 New Mexico State University. All rights reserved.
//

import UIKit

class PDFDisplayViewController: UIViewController {
    var route: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let url = Bundle.main.url(forResource: "NewRt\(route)", withExtension: "PDF")
        
        if let url = url {
            let webView = UIWebView(frame: self.view.frame)
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest)
            
            view.addSubview(webView)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
