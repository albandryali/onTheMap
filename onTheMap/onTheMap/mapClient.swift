//
//  MapClient.swift
//  onTheMap
//
//  Created by albandry on 26/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation

class MapClient {
    
    enum Endpoints {
        
        static let base =  "https://onthemap-api.udacity.com/v1/StudentLocation"
      
        
        case getStudentLocation
        case getUserURL
        case replaceLocationURL
        case loginORlogOut
        
        var stringValue : String {
            switch self {
case .getStudentLocation:return Endpoints.base + "?limit=100" + "&order=-updatedAt"            case .getUserURL: return  "https://onthemap-api.udacity.com/v1/users/\(SavedStudentResult.uniqueKey)"
            case .replaceLocationURL:return "https://onthemap-api.udacity.com/v1/StudentLocation\(SavedStudentResult.objectId)"
            case .loginORlogOut: return "https://onthemap-api.udacity.com/v1/session"
            }
            
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
    
    class func replaceLocation(completion:@escaping (Bool,Error?)->Void) {
        
        var request = URLRequest(url: Endpoints.replaceLocationURL.url)
        
        request.httpMethod = "PUT"
        request.addValue(RequestHelpers.content.parseAppId , forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(RequestHelpers.content.restApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let newlocation = PostStudentLocationRequst(uniqueKey: SavedStudentResult.uniqueKey, firstName: SavedStudentResult.firstName, lastName: SavedStudentResult.lastName, mapString: SavedStudentResult.mapString, mediaURL: SavedStudentResult.mediaURL, latitude: SavedStudentResult.latitude, longitude: SavedStudentResult.longitude)
        
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(newlocation)
        } catch {
            DispatchQueue.main.async {
                completion(false,error)
            }
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false,error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseReplacingLocation.self, from: data)
                DispatchQueue.main.async {
                    completion(true,nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false,error)
                }
            }
            
        }
        task.resume()
    }
    
    
    
    class func getStudentLocation(completion: @escaping ([StudentLocation],Error?)->Void) {
        
        RequestHelpers.taskGetrequest(url: Endpoints.getStudentLocation.url, responseT: StudentResult.self) { (response, error) in
            if let response = response {
                completion(response.results , nil)
            } else {
                completion([], error)
            }
        }
    }
    
    //get fistName and last name
   class func getcurrentUser() {
        let request = URLRequest(url: MapClient.Endpoints.getUserURL.url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(CurrentUserData.self, from: newData)
                SavedStudentResult.firstName = responseObject.firstname ?? ""
                SavedStudentResult.lastName = responseObject.lastname ?? ""
            } catch {
                
            }
        }
        task.resume()
    }
    
    class func postStudentLocation(completion:@escaping (Bool,Error?)->Void) {
        
      let newlocation = "{ \"uniqueKey\": \"\(SavedStudentResult.uniqueKey)\", \"firstName\": \"\(SavedStudentResult.firstName)\", \"lastName\": \"\(SavedStudentResult.lastName)\", \"mapString\": \"\(SavedStudentResult.mapString)\", \"mediaURL\": \"\(SavedStudentResult.mediaURL)\", \"latitude\": \(SavedStudentResult.latitude), \"longitude\": \(SavedStudentResult.longitude) } "
        
       
         RequestHelpers.taskPostRequest(body: newlocation , response: newLocarionResponse.self, url: Endpoints.getStudentLocation.url, udacityClient : false) { (response, error) in
            if response != nil {
                completion(true,nil)
                SavedStudentResult.objectId = response?.objectId ?? ""
            } else {
                completion(false,error)
            }
        }
    }
    
    

    
    
    
}
