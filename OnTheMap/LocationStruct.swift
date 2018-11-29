//
//  LocationStruct.swift
//  OnTheMap
//
//  Created by Christopher Tropiano on 11/29/18.
//  Copyright © 2018 chrisTropiano. All rights reserved.
//

import Foundation

struct StudentLocations: Codable {
    let objectID: String?
    let uniqueKey: String?
    let firstName: String?
    let lastname: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    
}
