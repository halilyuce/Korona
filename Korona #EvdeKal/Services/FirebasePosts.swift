//
//  FirebasePosts.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 29.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import FirebaseFirestore

let dbCollectionPosts = Firestore.firestore().collection("gonderiler")
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
                    
                    if let comments = diff.document.get("comments") as? [Comment] {
                        print(diff.document.get("title")!)
                        print(comments)
                    }
                   
                    let msgData = Post(dictionary: diff.document.data())
                    self.data.append(msgData)
                }
                
                // Real time modify from server
                if (diff.type == .modified) {
                    self.data = self.data.map { (eachData) -> Post in
                        let data = eachData
                        if data.id == diff.document.documentID {
                            data.title = diff.document.get("title") as! String
                            data.content = diff.document.get("content") as! String
                            data.user = diff.document.get("user") as! String
                            data.comments = diff.document.get("comments") as! [Comment]
                            data.date = diff.document.get("date") as! Timestamp
                            return data
                        }else {
                            return eachData
                        }
                    }
                }
                
                if (diff.type == .removed) {
                   let docId = diff.document.documentID
                   if let indexOfToRemove = self.data.firstIndex(where: { $0.id == docId} ) {
                       self.data.remove(at: indexOfToRemove)
                       print("removed: \(docId)")
                   }
               }
                
            }
        }
    }
}
