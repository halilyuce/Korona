//
//  Post.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 29.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import Firebase

struct Post: Codable {
    var id: String = ""
    var title: String = ""
    var content: String = ""
    var user: String = ""
    var comments: [Comment] = []
    var date: Timestamp
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.content = dictionary["content"] as? String ?? ""
        self.user = dictionary["user"] as? String ?? ""
        self.comments = dictionary["comments"] as? [Comment] ?? [Comment]()
        self.date = dictionary["date"] as? Timestamp ?? Timestamp(date: Date())
    }
    
}


