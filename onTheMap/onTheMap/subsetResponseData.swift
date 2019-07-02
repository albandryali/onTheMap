//
//  subsetResponseData.swift
//  onTheMap
//
//  Created by albandry on 01/06/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import UIKit

class subsetResponseData : UIViewController {
    
  func rangeData ( data : Data ) -> Data {
    let range = 5..<data.count
    let newData = data.subdata(in: range )
        
       return newData
        
    }
}
