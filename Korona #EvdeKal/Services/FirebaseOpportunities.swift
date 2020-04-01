//
//  FirebaseOpportunities.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 1.04.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import FirebaseFirestore

let dbCollectionOpportunities = Firestore.firestore().collection("firsatlar")
let firebaseOpportunities = FirebaseOpportunities()

class FirebaseOpportunities: ObservableObject {
    
    @Published var data = [Opportunities]()
    
    init() {
        readData()
    }
    
    func readData() {
        dbCollectionOpportunities.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    let msgData = Opportunities(id: diff.document.documentID, title: diff.document.get("title") as! String, image: diff.document.get("image") as! String, link: diff.document.get("link") as! String, type: diff.document.get("type") as! String, code: diff.document.get("code") as! String)
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
                    self.data = self.data.map { (eachData) -> Opportunities in
                        var data = eachData
                        if data.id == diff.document.documentID {
                            data.title = diff.document.get("title") as! String
                            data.type = diff.document.get("type") as! String
                            data.image = diff.document.get("image") as! String
                            data.link = diff.document.get("link") as! String
                            data.code = diff.document.get("code") as! String
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
