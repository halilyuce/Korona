//
//  Health.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Health: Identifiable {
    var id: String
    var title: String
    var category: String
    var description: String
    var video: String
    var image: String
    var link: String
    var created_at: Timestamp
}

