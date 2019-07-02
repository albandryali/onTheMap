//
//  LogOutSessionResponse.swift
//  onTheMap
//
//  Created by albandry on 31/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation

struct LogOutSessionResponse: Codable {
    
    
    let session:Session
    
    struct Session:Codable {
        let id: String
        let expiration:String
        
    }
    
    
}
