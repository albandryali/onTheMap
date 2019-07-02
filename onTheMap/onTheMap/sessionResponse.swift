//
//  sessionResponse.swift
//  onTheMap
//
//  Created by albandry on 28/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation

// session responser
struct sessionResponse : Codable {
    
    let account : Account
    let session : urlSession
    
}

struct Account : Codable {
    let signedIn : Bool
    let key : String
}

struct urlSession : Codable {
    let id : String
    let expiration:String

}
