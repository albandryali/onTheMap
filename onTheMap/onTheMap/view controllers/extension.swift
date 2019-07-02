//
//  Alerts.swift
//  onTheMap
//
//  Created by albandry on 26/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation
import UIKit



extension UIViewController  {
    
  //  var indicator : UIActivityIndicatorView!
    
    func printAlert(_ title:String ,_ message:String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alertVC, animated:true, completion:nil)
        
    }
    
    
    func setUpindicator(indicator :  UIActivityIndicatorView ) {
        if indicator.isAnimating {
            indicator.stopAnimating()
        } else {
            indicator.startAnimating()
        }
    }
    
    func getStudentData() {
        
        MapClient.getStudentLocation { (studentsLocationResult , error) in
            if error != nil {
                self.printAlert(" ", error!.localizedDescription )
            } else {
                SavedStudentResult.results = studentsLocationResult
            }
        }
    
    
}

}
    
    

