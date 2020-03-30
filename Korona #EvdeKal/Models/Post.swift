//
//  Post.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 29.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Post: Codable {
    var id: String
    var title: String
    var content: String
    var user: String
    var comments: Array<Comments>
    var created_at: Timestamp
}



