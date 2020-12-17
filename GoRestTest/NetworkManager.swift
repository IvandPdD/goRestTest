//
//  NetworkManager.swift
//  GoRestTest
//
//  Created by Rodrigo Hernández Gómez on 17/12/2020.
//  Copyright © 2020 Rodrigo Hernández Gómez. All rights reserved.
//

import Foundation
import Alamofire

class Post: Codable{
    
    let name: String
    let gender: String
    let email: String
    let status: String
    
    init(name: String, gender: String, email: String, status: String) {
        self.name = name
        self.gender = gender
        self.email = email
        self.status = status
    }
}

class Network {
    
    static var shared: Network = Network()
    
}


protocol GoRestAPI {
    
    func getUsers()
    
    func postUser()
    
    /*func patchUser()
    
    func putUser()
    
    func deleteUser()*/
    
}


extension Network: GoRestAPI {
    
    static let ACCESS_TOKEN = "*****"
    
    //TODO
    func getUsers() {
        let headers = ["content-type": "application/json", "accept": "application/json"]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://gorest.co.in/public-api/posts")! as URL,
            cachePolicy: .useProtocolCachePolicy,
        timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
          }
        })

        dataTask.resume()
        
    }
    
    //TODO
    func postUser() {
        let headers = ["content-type": "application/json", "accept": "application/json", "authorization": "bearer ACCESS_TOKEN"]

        let newPost = Post(name: "Juan", gender: "Male", email: "comemeloshuevos@gmail.com", status: "Active")
        
        let encoder = JSONEncoder.init()
        
        var postData: Data!
        
        do {
            let postSerilized = try! encoder.encode(newPost)
            postData = try! Data(encoder.encode(newPost))
        }catch{
            print(error)
        }

        let request = NSMutableURLRequest(url: NSURL(string: "https://gorest.co.in/public-api/users")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
          }
        })

        dataTask.resume()
    }
    
    //TODO
   /* func patchUser() {
        <#code#>
    }
    
    //TODO
    func putUser() {
        <#code#>
    }
    
    //TODO
    func deleteUser() {
        <#code#>
    }*/
    
}
