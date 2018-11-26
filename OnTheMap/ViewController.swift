//
//  ViewController.swift
//  OnTheMap
//
//  Created by Christopher Tropiano on 11/12/18.
//  Copyright © 2018 chrisTropiano. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    let appdelegate = AppDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func authenticateUser() {
        
    var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
       request.httpMethod = "POST"
       request.addValue("application/json", forHTTPHeaderField: "Accept")
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(loginTextField.text!)\", \"password\": \"\(passwordTextField.text!)\"}}".data(using: .utf8)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error ) in
            
            let loginAlert = UIAlertController(title: "You have entered the wrong username or password. Please try again.", message: "Try Again", preferredStyle: .alert)
            loginAlert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            
            let range = 5..<data!.count
            let newData = data?.subdata(in: range) /* subset response data! */
            
            let parsedResult: [String: AnyObject]!
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as? [String:AnyObject]
            } catch {
                print(error)
                return
            }
            
            guard let statusCode = parsedResult["status_code"] as? Int
                else {
                    print("There was no error so therefore, no status code was returned")
                    return
                }
            if statusCode == 400 {
                self.present(loginAlert, animated: true)
            } else if statusCode == 401 {
                self.present(loginAlert, animated: true)
            }
            
            guard let session = parsedResult["session"] as? [String: AnyObject],
            let sessionID = session["ID"] as? Int
                else {
                    print("The sessionId was not parsed")
                    return
            }
            print(sessionID)
           
        }
        task.resume()
    }
    
    @IBAction func LoginPressed(_ sender: Any) {
      loginButton.isEnabled = false
      loginButton.setTitle("Loading...", for: .normal)
       authenticateUser()
    }
    
    @IBAction func SignUpPressed(_ sender: Any) {
        let openURL = "https://auth.udacity.com/sign-up"
        if let url = URL(string: openURL) {
            
            //Use safari controller so that the app launches website in view instead of outside launch.
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
            
        }
        
        
      
    }
    
}
    




