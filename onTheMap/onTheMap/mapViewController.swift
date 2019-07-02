//
//  ViewController.swift
//  onTheMap
//
//  Created by albandry on 22/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    var annotations = [MKPointAnnotation]()
     var locations = [studentLocation]()

    //MARK: life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getStudentsAnnotations ()
    }
    
    func getStudentsAnnotations () {
        
        mapClinet.studentLocation { (locations, error) in
            self.mapView.removeAnnotations(self.annotations)
            self.annotations.removeAll()
            self.locations = locations
            for dictionary in locations {
                let lat = CLLocationDegrees(studentData.latitude )
                let long = CLLocationDegrees(studentData.longtitude )
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let first = studentData.firstName
                let last = studentData.lastName
                let mediaURL = dictionary.mediaURL
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                self.annotations.append(annotation)
        }
        
       
            DispatchQueue.main.async {
                self.mapView.addAnnotations(self.annotations)
            }
        }

    }

    @IBAction func LogOut(_ sender: Any) {
 
  udacityClient.logOutSession { (success, error) in
    if success {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! Login
        self.present(vc , animated: true , completion: nil)
    } else {
        print("error")
    }
        }
    }
    
    
    @IBAction func addNewLocation(_ sender: Any)
    {
        
        
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        
        mapClinet.studentLocation { (studenLocation , error ) in
            if error != nil {
                //show alert
            } else {
                studentData.data = studenLocation
            }
        }
            
            
        
        
    }
    
    
}

extension mapViewController : MKMapViewDelegate {
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
    
}

