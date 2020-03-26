//
//  HTTPManager.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 20.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation

class HttpManager {
    static let shared = HttpManager()
    
    private init() { }
    
    enum HttpError: Error {
        case invalidResponse(Data?, URLResponse?)
    }
    
    
    public func get(_ url: URL, completionBlock: @escaping (Result<Data, Error>) -> Void) {

        let headers = [
          "content-type": "application/json",
          "authorization": "apikey 3N2vctymSkVCSRmxRn0lZ4:5aPeaI9jgMZr56t49ZCYbI"
        ]
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }
            
            guard
                let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(HttpError.invalidResponse(data, response)))
                    return
            }
            
            completionBlock(.success(responseData))
        }
        task.resume()
    }
}

