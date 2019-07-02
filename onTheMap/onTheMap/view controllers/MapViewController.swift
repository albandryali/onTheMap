//
//  MapViewController.swift
//  onTheMap
//
//  Created by albandry on 26/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate {
    
   // var alerts = General()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addAnnotations()
    }
    
    @IBAction func logOut(_ sender: Any) {
        UdacityClient.logOutSession { (success, error) in
            if success {
                //if log out successed move to "loginViewController"
              let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                
                vc.dismiss(animated: true, completion: nil)
                
                self.present(vc, animated: true,completion: nil)
            } else {
                self.printAlert("Ops:", error?.localizedDescription ?? "")
            }
        }
    }
    
    @IBAction func add(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "navigatorToFindLocation") as! AddLocationViewController
        present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func refresh(_ sender: Any) {
         getStudentData()
    }
    

    
    func addAnnotations() {
        
        var annotationArray = [MKPointAnnotation]()
        let students = SavedStudentResult.results
        
        for student in students {
            
            let lat = CLLocationDegrees(student.latitude ?? 0.0)
            let long = CLLocationDegrees(student.longitude ?? 0.0)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = student.firstName ?? ""
            let last = student.lastName ?? ""
            let mediaURL = student.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            annotationArray.append(annotation)
        }
        self.mapView.addAnnotations(annotationArray)
    }
    
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    
}
