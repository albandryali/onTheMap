//
//  RequestHelpers.swift
//  onTheMap
//
//  Created by albandry on 26/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation

class RequestHelpers {
    
    struct content {
        static let parseAppId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let restApiKey =  "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    
  
    //Task Get Request
    class func taskGetrequest<responseType:Decodable>(url:URL ,responseT:responseType.Type, completion: @escaping (responseType?,Error?)->Void) {
        
        var request = URLRequest(url: url)
       request.addValue(content.parseAppId ,forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue(content.restApiKey , forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil , error)
                }
                return
            }
            
            print(data)
            do {
                let decoder = JSONDecoder()
                
                let responseObject = try decoder.decode(responseT.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil,error)
                    print(error)
                }
            }
            
        }
        task.resume()
    }
    
    //Task Post Request
    class func taskPostRequest<responseType:Codable >(body: String ,response:responseType.Type,url:URL, udacityClient : Bool ,completion: @escaping (responseType?,Error?)->Void ) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        if udacityClient == false {
      
        request.addValue(content.parseAppId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(content.restApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        do {
           request.httpBody = try encoder.encode(body)
        } catch {
            DispatchQueue.main.async {
                completion(nil,error)
            }
        }
        } else if udacityClient == true {
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body.data(using: .utf8)

        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                return
            }
            if udacityClient == true {
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(responseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject,nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
            } else {
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(responseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject,nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil,error)
                    }
                }
            }
        }
        task.resume()
        
        
    }
    
    
    
}
