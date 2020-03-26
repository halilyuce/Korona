//
//  NewsVM.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 20.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation

class NewsVM: ObservableObject {
    
    @Published var news = [NewsResult]()
    @Published var alert:Bool = false
    
    init() {
        fetchNews()
    }
}

extension NewsVM {
    func fetchNews() {
        ApiManager.shared.fetchNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.news = result.result
            case .failure(_):
                self.alert = true
            }
        }
    }
}

