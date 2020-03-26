//
//  FirebaseCovid.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import FirebaseFirestore

let dbCollectionCovid = Firestore.firestore().collection("covid19")
let firebaseCovid = FirebaseCovid()

class FirebaseCovid: ObservableObject {
    
    @Published var data = [Covid]()
    
    init() {
        readData()
    }
    
    func readData() {
        dbCollectionCovid.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    let msgData = Covid(id: diff.document.documentID, title: diff.document.get("title") as! String, content: diff.document.get("content") as! String, image: diff.document.get("image") as! String)
                    self.data.append(msgData)
                }
                
                // Real time modify from server
                if (diff.type == .modified) {
                    self.data = self.data.map { (eachData) -> Covid in
                        var data = eachData
                        if data.id == diff.document.documentID {
                            data.title = diff.document.get("title") as! String
                            data.content = diff.document.get("content") as! String
                            data.image = diff.document.get("image") as! String
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
