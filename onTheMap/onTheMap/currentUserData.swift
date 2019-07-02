//
//  currentUserData.swift
//  onTheMap
//
//  Created by albandry on 29/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation

struct currentUserData : Codable {
    
    let firstname : String
    let lastname : String 
    
    
    enum CodingKeys:String, CodingKey {
        
        case firstname = "first_name"
        case lastname = "last_name"
        
    }
}
