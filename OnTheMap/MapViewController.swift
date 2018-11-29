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
        logout()
        performSegue(withIdentifier: "logoutPressed", sender: self)
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        getMultipleLocations()
    }
    
    @IBAction func addPressed(_ sender: Any) {
    }
    
    
    func logout() {
            var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
            request.httpMethod = "DELETE"
            var xsrfCookie: HTTPCookie? = nil
            let sharedCookieStorage = HTTPCookieStorage.shared
            for cookie in sharedCookieStorage.cookies! {
                if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
            }
            if let xsrfCookie = xsrfCookie {
                request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
            }
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil {
                    print(error)
                    return
                }
                let range = 5..<data!.count
                let newData = data?.subdata(in: range)
                print(String(data: newData!, encoding: .utf8)!)
            }
            task.resume()
        }
    
    func getMultipleLocations() {
        taskForGETMethod(url: URL(string:"https://parse.udacity.com/parse/classes/StudentLocation?limit=100")!)
       
        
}



}
