//
//  ViewController.swift
//  OnTheMap
//
//  Created by Christopher Tropiano on 11/12/18.
//  Copyright © 2018 chrisTropiano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getSessionID() {
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        
       request.httpMethod = "Post"
       request.addValue("application/json", forHTTPHeaderField: "Accept")
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = {"udacity\": {\"username\": \"\(loginTextField.text!)\", \"password\": \"\(passwordTextField.text!)"}().data(using: .utf8)
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: request) { (data, response, error ) in
            
            let alert = UIAlertController(title: "The Login has failed", message: "Try Again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
            
            let parsedResult: [String:AnyObject]!
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
            } catch {
                print("The data was unable to be parsed")
                return
            }
            
            guard let statusCode = parsedResult["status_code"] as? Int
                else {
                    print("There was no error so therefore, no status code was returned")
                    return
                }
            if statusCode == 400 {
                self.present(alert, animated: true)
            } else if statusCode == 401 {
                self.present(alert, animated: true)
            }
            
            
            
            
        }
        task.resume()
    }
}
    




