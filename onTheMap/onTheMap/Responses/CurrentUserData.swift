//
//  CurrentUserData.swift
//  onTheMap
//
//  Created by albandry on 31/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//



import Foundation

struct CurrentUserData : Codable {
    
    let firstname :String?
    let lastname :String?
    
    
    enum CodingKeys:String, CodingKey {
        
        case firstname = "first_name"
        case lastname = "last_name"
        
    }
    
}
