//
//  SessionResponse.swift
//  onTheMap
//
//  Created by albandry on 31/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation

struct SessionResponse :Codable {
    let account: Account
    let session: Session
    
    
}

struct Account : Codable {
    let registered : Bool
    let key : String
}

struct Session : Codable {
    let id: String
    let expiration:String
}
