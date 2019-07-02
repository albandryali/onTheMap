//
//  MapTableViewController.swift
//  onTheMap
//
//  Created by albandry on 26/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class  MapTableViewController : UITableViewController {
    
    //var alerts = General()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    
    @IBAction func logOut(_ sender: Any) {
        UdacityClient.logOutSession { (success, error) in
            if success {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                self.present(vc, animated: true,completion: nil)
            } else {
                self.printAlert(" ", error?.localizedDescription ?? "")
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
    
    

}
//MARK:TableView
extension MapTableViewController  {
    
  
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  SavedStudentResult.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(SavedStudentResult.results[indexPath.row].firstName ?? "") \(SavedStudentResult.results[indexPath.row].lastName ?? "")"
        cell.detailTextLabel?.text = "\(SavedStudentResult.results[indexPath.row].mediaURL ?? "" )"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let Url = SavedStudentResult.results[indexPath.row].mediaURL
        let studentUrl = URL(string: Url ?? "")
        
        if let studentUrl = studentUrl  {
            //check if it hass http or https
            if (Url?.hasPrefix("http://"))! || (Url?.hasPrefix("https://"))! {
                UIApplication.shared.open(studentUrl, options: [:], completionHandler: nil)
            } else {
                self.printAlert("Invailed url", "URL must include http:// or https:// ")
            }
        }
    }
    
    
}
