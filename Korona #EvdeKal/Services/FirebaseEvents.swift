//
//  FirebaseEvents.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import FirebaseFirestore

let dbCollectionEvents = Firestore.firestore().collection("etkinlikler")
let firebaseEvents = FirebaseEvents()

class FirebaseEvents: ObservableObject {
    
    @Published var data = [Events]()
    
    init() {
        readData()
    }
    
    func readData() {
        dbCollectionEvents.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    let msgData = Events(id: diff.document.documentID, title: diff.document.get("title") as! String, image: diff.document.get("image") as! String, link: diff.document.get("link") as! String, type: diff.document.get("type") as! String, date: diff.document.get("date") as! String)
                    self.data.append(msgData)
                }
                
                // Real time modify from server
                if (diff.type == .modified) {
                    self.data = self.data.map { (eachData) -> Events in
                        var data = eachData
                        if data.id == diff.document.documentID {
                            data.title = diff.document.get("title") as! String
                            data.type = diff.document.get("type") as! String
                            data.image = diff.document.get("image") as! String
                            data.link = diff.document.get("link") as! String
                            data.date = diff.document.get("date") as! String
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

