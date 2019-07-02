//
//  SubmitLocation.swift
//  onTheMap
//
//  Created by albandry on 31/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation
import MapKit

class SubmitLocation : UIViewController , MKMapViewDelegate{
    
   // var alerts = General()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var submitButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 0.5)
        submitButton.setTitleColor(.white, for: .normal)
        
        mapView.delegate = self
        
        getStudentAnnotation()
        
    }
    
    @IBAction func submit(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController")
        // if the user already submited location so check it not empty
        if SavedStudentResult.objectId != "" {
            MapClient.replaceLocation { (success , error) in
                if success {
                    self.printAlert("has been submit it successfully ", " ")
                    self.present(vc!, animated: true, completion: nil)
                } else {
                    self.printAlert("Error", error?.localizedDescription ?? "")
                }
            }
        } else {
            // if the user post the location for first time
            MapClient.postStudentLocation { (success, error) in
                if success {
                    self.printAlert("you already have post a location", " ")
                    self.present(vc!, animated: true,completion: nil)
                } else {
                    self.printAlert("Error", error?.localizedDescription ?? "")
                }
            }
        }
        
    }
    
   
  
    
    
    func getStudentAnnotation () {
        
        
        let lat = CLLocationDegrees(SavedStudentResult.latitude )
        let long = CLLocationDegrees(SavedStudentResult.longitude)
       
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
     
        
        let first = SavedStudentResult.firstName
        let last = SavedStudentResult.lastName
        let mediaURL = SavedStudentResult.mediaURL
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(first) \(last)"
        annotation.subtitle = mediaURL
        
        var region:MKCoordinateRegion {
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            return MKCoordinateRegion(center: annotation.coordinate, span: span)
        }
        
        self.mapView.addAnnotation(annotation)
        //zoom to annotation
        self.mapView.setRegion(region ,animated: true)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
}
