//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Christopher Tropiano on 11/22/18.
//  Copyright © 2018 chrisTropiano. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutPressed(_ sender: Any) {
        performSegue(withIdentifier: "logoutPressed", sender: self)
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
    }
    
    @IBAction func addPressed(_ sender: Any) {
    }
    
    
    func logout() {
        
    }

}
