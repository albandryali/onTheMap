//
//  TableViewController.swift
//  onTheMap
//
//  Created by albandry on 23/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import UIKit

class TableViewController : UITableViewController
    
{
    

   
    @IBOutlet var tableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.reloadData()
     
    }
    
    
    
    //MARK: button actions
    @IBAction func refresh(_ sender: Any)
    {
        
    }
    
    
    @IBAction func post(_ sender: Any)
    {
        
    }
    
    @IBAction func logOut(_ sender: Any)
    {
        udacityClient.logOutSession { (secusse, error ) in
            if secusse {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login") as? Login
                self.present(vc! , animated: true , completion: nil)
            } else {
                print("Eror login")
            }
        }
    }
    
    
    
    
    func openUrl (url: String)
    {
        guard let _url = URL(string: url) else
        {
            let alert = UIAlertController(title: "Invalid URL", message: "The provided URL is invalid", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        UIApplication.shared.open(_url, options: [:], completionHandler: nil)
    }
    
}

//MARK: tableView

    extension TableViewController  {
     
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return studentData.data.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let information = studentData.data[indexPath.row]
        openUrl(url: information.mediaURL!)
    }
    
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    
    let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let studentLocation = studentData.data[indexPath.row]
    cell.textLabel?.text = "\(studentLocation.firstName ?? "N/A") \(studentLocation.lastName ?? "" )"
    cell.detailTextLabel?.text = "\(studentLocation.mediaURL ?? "" )"
   
    return cell
        }
        

        

    
}
