//
//  Comments.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 29.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import Firebase

class Comment: NSObject, Codable {
    var content: String = ""
    var user: String = ""
    var date: Timestamp = Timestamp(date: Date())
    
     init(dictionary: [String: Any]) {
        self.content = dictionary["id"] as? String ?? ""
        self.user = dictionary["user"] as? String ?? ""
        self.date = dictionary["date"] as? Timestamp ?? Timestamp(date: Date())
    }
}

