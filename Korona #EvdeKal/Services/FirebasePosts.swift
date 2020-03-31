//
//  FirebasePosts.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 29.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import FirebaseFirestore
import CodableFirebase

let dbCollectionPosts = Firestore.firestore().collection("konular")
let firebasePosts = FirebasePosts()

extension Timestamp: TimestampType {}
extension DocumentReference: DocumentReferenceType {}

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
                   
                    let model = try! FirestoreDecoder().decode(Post.self, from: diff.document.data())
                    self.data.append(model)
                }
                
                if (diff.type == .removed) {
                    let docId = diff.document.documentID
                    if let indexOfToRemove = self.data.firstIndex(where: { $0.id == docId} ) {
                        self.data.remove(at: indexOfToRemove)
                        print("removed: \(docId)")
                    }
                }

                // Real time modify from server
                if (diff.type == .modified) {
                    self.data = self.data.map { (eachData) -> Post in
                        var data = eachData
                        if data.id == diff.document.documentID {
                            return try! FirestoreDecoder().decode(Post.self, from: diff.document.data())
                        }else {
                            return eachData
                        }
                    }
                }
                
            }
        }
    }
}
