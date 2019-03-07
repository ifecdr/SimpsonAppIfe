//
//  SimpsonsSerive.swift
//  SimpsonsApp
//
//  Created by MAC Consultant on 3/2/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import Foundation

import UIKit


class SimpsonsService {
//    static let shared = SimpsonsService()
//    private let session: URLSession
//    private init() {
//        let config = URLSessionConfiguration.default
//        config.allowsCellularAccess = false
//        config.requestCachePolicy = .returnCacheDataElseLoad
//        session = URLSession.init(configuration: config)
//
//        // or just
//        // session = URLSession.shared
//    }
    //static let shared = SimpsonsService()
    var simpsonsCollection =  [Simpsons.RelatedTopics]()
    
    
    func downloadSimpsons(completion: @escaping (Simpsons)->()) {
        let url = URL(string: "https://api.duckduckgo.com/?q=simpsons+characters&format=json")!

        var request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: 3.0)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            if let dat = data {
                // parse the data
                let decoder = JSONDecoder()
                do {
                    //let jsonResponse = try JSONSerialization.jsonObject(with: dat, options: [])
                    //print(jsonResponse)
                    let simpsons = try decoder.decode(Simpsons.self, from: dat)
                    //self.simpsonsCollection = simpsons.relatedTopics
                    
                    //self.downloadPicture(for: simpsons, completion: completion)
                    
                    completion(simpsons)
                    
                    //let jsonDict = try JSONSerialization.jsonObject(with: simpsons, options: .mutableLeaves) as! [[String:Any]]
                    //print(self.simpsonsCollection)
                }
                catch {
                    // error, something
                    print(error)
                }
            }
        }
        task.resume()
        
    }
    
    
    func downloadPicture(for simp: Simpsons.RelatedTopics,
                         completion: @escaping (Simpsons.ImageStruct)->()) {
        
        let urlString = simp.url.url
        
        guard let url = URL(string: urlString) else {
            // error here
            return
        }
        
        let dataTaskComp: (Data?, URLResponse?, Error?)->() =
        { (data, _, _) in
            let image = Simpsons.ImageStruct.init(image: data)
            completion(image)
            print("34")
            // self.inProgressCalls.remove(urlString)
        }
        
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: dataTaskComp)
        
        dataTask.resume()
        
        
    }
}
