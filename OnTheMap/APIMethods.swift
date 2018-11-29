//
//  APIMethods.swift
//  OnTheMap
//
//  Created by Christopher Tropiano on 11/29/18.
//  Copyright © 2018 chrisTropiano. All rights reserved.
//

import Foundation

func taskForGETMethod(url: URL) {

    var request = URLRequest(url: url)
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { data, response, error in
        if error != nil {
            print(error!)
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            print("Your request returned a status code other than 2xx!")
            return
        }
        
        /* GUARD: Was there any data returned? */
        guard let data = data else {
            print("No data was returned by the request!")
            return
        }
        
        let parsedResult: [String: AnyObject]
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
        } catch {
            print("Did not parse correctly")
            return
        }
    
        
        do {
            let decoder = JSONDecoder()
            let location = try decoder.decode(StudentLocations.self, from: data)
            print(location)
        } catch {
            print("the data did not decode properly")
            return
        }
        
        
    }
       task.resume()
}

    


