//
//  newLocation.swift
//  onTheMap
//
//  Created by albandry on 28/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation

struct NewLocation : Codable {
    
    let uniqueKey : String
    let firstName : String
    let lastName : String
    let mapString : String
    let mediaURL : String
    let latitude : Double
    let longtitude : Double
    
}
