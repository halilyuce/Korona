//
//  FirebaseData.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 20.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import FirebaseFirestore

let dbCollection = Firestore.firestore().collection("health")
let firebaseData = FirebaseData()

class FirebaseData: ObservableObject {
    
    @Published var data = [Health]()
    
    init() {
        readData()
    }
    
    func readData() {
        dbCollection.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    let msgData = Health(id: diff.document.documentID, title: diff.document.get("title") as! String, category: diff.document.get("category") as! String, description: diff.document.get("description") as! String, video: diff.document.get("video") as! String, image: diff.document.get("image") as! String, link: diff.document.get("link") as! String, created_at: diff.document.get("created_at") as! Timestamp)
                    self.data.append(msgData)
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
                    self.data = self.data.map { (eachData) -> Health in
                        var data = eachData
                        if data.id == diff.document.documentID {
                            data.title = diff.document.get("title") as! String
                            data.description = diff.document.get("description") as! String
                            data.category = diff.document.get("category") as! String
                            data.video = diff.document.get("video") as! String
                            data.image = diff.document.get("image") as! String
                            data.link = diff.document.get("link") as! String
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
