//
//  addNewLocationController.swift
//  onTheMap
//
//  Created by albandry on 28/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import UIKit
import MapKit
class addNewLocationController : UIViewController {
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var web: UITextField!
    
    
    @IBAction func findLocation(_ sender: Any) {
        
        getCoordinate(addressString: location.text ?? "") { (cordinates, error) in
            if error != nil {
                
                //print the error to User
              
            } else {
                //make sure that text field not empty
                if self.web.text != "" {
                    
                    //make sure that the webSite is vailed
                    if (self.web.text?.hasPrefix("http://"))!   || (self.web.text?.hasPrefix("https://"))!  {
                        
                        //set data that will be used for posting location
                        studentData.mapString = self.location.text ?? ""
                        studentData.latitude = cordinates.latitude
                        studentData.longtitude = cordinates.longitude
                        studentData.mediaURL = self.web.text ?? ""
                        
                        //perform Segue
                        let vc = self.storyboard?.instantiateViewController(withIdentifier:"addNewLocationController")
                        self.present(vc!, animated: true, completion: nil)
                        
                    } else {
                       //alert
                    }
                    
                }
            }
        }
        
        
    }
    
    
    func getCoordinate(addressString: String, completion: @escaping(CLLocationCoordinate2D, NSError?) -> Void)
    {
         let geocoder = CLGeocoder()
 geocoder.geocodeAddressString(addressString) { ( placemarks, Error) in
            if Error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    completion(location.coordinate, nil)
                }
            }  else {
                completion(kCLLocationCoordinate2DInvalid, Error as NSError?)
    }
        }
    }
    
    
}
