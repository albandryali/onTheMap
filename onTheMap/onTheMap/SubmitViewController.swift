//
//  submitViewController.swift
//  onTheMap
//
//  Created by albandry on 28/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import UIKit
import MapKit

class SubmitViewController : UIViewController , MKMapViewDelegate{
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    
  
    
    
    @IBAction func submit(_ sender: Any){
        //prepare the view controller
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        //check if the user already submited location
        if studentData.objectId != "" {
            //replacing location
            mapClinet.replaceStudentLocation { (success, error) in
                if success {
                    //move to tab bar controller
                    // BEFORE : self.present(vc, animated: true, completion: nil)
                    vc.dismiss(animated: true, completion: nil)
                } else {
                    //print alert to user
                   // self.alerts.printAlert("ops", error?.localizedDescription ?? "")
                }
            }
        } else {
            //first time user post location
            mapClinet.postStudentLocation { (success, error) in
                if success {
                    self.present(vc, animated: true,completion: nil)
                } else {
                   // self.alerts.printAlert("ops", error?.localizedDescription ?? "")
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        //call the method to creat annotation of user's location
        getStudentAnnotation()
        
    }
    
    
    //creat annotation of user's location
    func getStudentAnnotation () {
        
        
        let lat = CLLocationDegrees(studentData.latitude )
        let long = CLLocationDegrees(studentData.longtitude)
        
        // The lat and long are used to create a CLLocationCoordinates2D instance.
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        //zoom to cordinate
        
        
        
        let first = studentData.firstName
        let last = studentData.lastName
        let mediaURL = studentData.mediaURL
        
        // Here we create the annotation and set its coordiate, title, and subtitle properties
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(first) \(last)"
        annotation.subtitle = mediaURL
        
        var region:MKCoordinateRegion {
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            return MKCoordinateRegion(center: annotation.coordinate, span: span)
        }
}

}
