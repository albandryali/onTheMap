//
//  UdacityClient.swift
//  onTheMap
//
//  Created by albandry on 26/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation

class UdacityClient {
    
    class func loginSession (username:String, password:String , completion: @escaping (Bool,Error?)->Void) {
        let body = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        
        RequestHelpers.taskPostRequest(body: body, response: SessionResponse.self, url: MapClient.Endpoints.loginORlogOut.url, udacityClient: true) { (responseURL , error) in
            if let responseURL = responseURL {
            if responseURL.account.registered {
                DispatchQueue.main.async {
                    SavedStudentResult.uniqueKey = responseURL.account.key
                    completion(true,nil)
                }
                }
            } else {
                DispatchQueue.main.async {
                    completion(false,error)
                }
        }
        }
      
       
    }
    
    class func logOutSession(completion:@escaping (Bool,Error?)->Void) {
       var request = URLRequest(url: MapClient.Endpoints.loginORlogOut.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false,error)
                }
                return
            }
            do {
                let range = 5..<data.count
                let newData = data.subdata(in: range)
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(LogOutSessionResponse.self, from: newData)
                print("sessionresponse\(responseObject)")
            } catch {
                DispatchQueue.main.async {
                    completion(false,error)
                }
            }
            DispatchQueue.main.async {
                completion(true,nil)
            }
        }
        task.resume()
    }
    
}

