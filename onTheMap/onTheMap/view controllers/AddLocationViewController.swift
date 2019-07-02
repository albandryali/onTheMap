//
//  AddLocationViewController.swift
//  onTheMap
//
//  Created by albandry on 26/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddLocationViewController : UIViewController {
    
    //var alerts = General()
    
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var websiteText: UITextField!
    @IBOutlet weak var findButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findButton.setTitleColor(.white, for: .normal)
    }
    
 
    
    func getCoordinate(addressString: String, completion: @escaping(CLLocationCoordinate2D, NSError?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            
            if error == nil {
                
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    completion(location.coordinate, nil)
                }
            }
            else {
                completion(kCLLocationCoordinate2DInvalid, error as NSError?)
            }
        }
    }
    
    @IBAction func findLocation(_ sender: Any) {
        
        getCoordinate(addressString: locationText.text ?? "") { (cordinates, error) in
            if error != nil {
                
                self.printAlert("invailed", error?.localizedDescription ?? "")
            } else {
                if self.websiteText.text != "" {
                    
                    // should be https or http
                    if (self.websiteText.text?.hasPrefix("http://"))!   || (self.websiteText.text?.hasPrefix("https://"))!  {
                        
                        SavedStudentResult.latitude = cordinates.latitude
                        SavedStudentResult.longitude = cordinates.longitude
                        SavedStudentResult.mapString = self.locationText.text ?? ""
                        SavedStudentResult.mediaURL = self.websiteText.text ?? ""
                        
                        
                        self.performSegue(withIdentifier: "toSubmit", sender: nil)
                        
                    } else {
                        self.printAlert("invailed", "URL should start with http:// or https://")
                    }
                    
                }
            }
        }
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
