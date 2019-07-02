//
//  SessionRequest.swift
//  onTheMap
//
//  Created by albandry on 26/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation

struct SessionRequest: Codable {
    
    let udacity: [String:String]
    let username: String
    let password: String
}
