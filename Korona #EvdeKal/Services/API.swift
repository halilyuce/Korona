//
//  API.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 20.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import Bagel

class ApiManager {
    static let shared = ApiManager()
    
    private init() { }
    
    let baseUrl = URL(string: "https://api.collectapi.com/corona/")!
    let newsExtensionURL = "coronaNews"
    
    func fetchNews(completion: @escaping (Result<CoronaNews, Error>) -> Void) {
        let url = baseUrl.appendingPathComponent(newsExtensionURL)
        
        Bagel.start()
        
        HttpManager.shared.get(url) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async { completion(.failure(error)) }
                
            case .success(let data):
                do {
                    let news = try JSONDecoder().decode(CoronaNews.self, from: data)
                    DispatchQueue.main.async { completion(.success(news)) }
                } catch {
                    print(error)
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
    
}
