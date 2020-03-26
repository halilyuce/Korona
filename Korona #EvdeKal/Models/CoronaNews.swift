//
//  News.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 20.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation

struct CoronaNews: Decodable {
    let success: Bool
    let result: [NewsResult]
}

struct NewsResult: Decodable {
    let url: String
    let description: String
    let image: String
    let name: String
    let source: String
    let date: String
}

