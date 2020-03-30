//
//  FirebasePosts.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 29.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import FirebaseFirestore

let dbCollectionPosts = Firestore.firestore().collection("basliklar")
let firebasePosts = FirebasePosts()

class FirebasePosts: ObservableObject {
    
    @Published var data = [Post]()
    
    init() {
        readData()
    }
    
    func readData() {
        dbCollectionPosts.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    if let comments = diff.document.get("comments") as? [Any] {
                        print(comments)
                    }
                    
                    let msgData = Post(id: diff.document.documentID, title: diff.document.get("title") as! String, content: diff.document.get("content") as! String, user: diff.document.get("user") as! String, comments: [Comments(body: "Test", user: "xalo", created_at: Timestamp(date: Date())), Comments(body: "Test yorum biraz daha uzun ve şey hali", user: "halil", created_at: Timestamp(date: Date())), Comments(body: "Test yorum biraz daha uzun ve şey hali ve aslında daha da uzun olmalıki uzun yazınca ne kadar farklı duruyor daha rahat şekilde görelim ki bir anlamı olsun değil mi ?", user: "esila", created_at: Timestamp(date: Date()))], created_at: diff.document.get("created_at") as! Timestamp)
                    self.data.append(msgData)
                }
                
                // Real time modify from server
                if (diff.type == .modified) {
                    self.data = self.data.map { (eachData) -> Post in
                        var data = eachData
                        if data.id == diff.document.documentID {
                            data.title = diff.document.get("title") as! String
                            data.content = diff.document.get("content") as! String
                            data.user = diff.document.get("user") as! String
                            data.comments = diff.document.get("comments") as! [Comments]
                            data.created_at = diff.document.get("created_at") as! Timestamp
                            return data
                        }else {
                            return eachData
                        }
                    }
                }
            }
        }
    }
}
