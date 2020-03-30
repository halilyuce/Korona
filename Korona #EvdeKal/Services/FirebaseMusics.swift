//
//  FirebaseMusics.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import FirebaseFirestore

let dbCollectionMusics = Firestore.firestore().collection("muzikler")
let firebaseMusics = FirebaseMusics()

class FirebaseMusics: ObservableObject {
    
    @Published var data = [Musics]()
    
    init() {
        readData()
    }
    
    func readData() {
        dbCollectionMusics.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    let msgData = Musics(id: diff.document.documentID, title: diff.document.get("title") as! String, image: diff.document.get("image") as! String, link: diff.document.get("link") as! String, type: diff.document.get("type") as! String)
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
                    self.data = self.data.map { (eachData) -> Musics in
                        var data = eachData
                        if data.id == diff.document.documentID {
                            data.title = diff.document.get("title") as! String
                            data.type = diff.document.get("type") as! String
                            data.image = diff.document.get("image") as! String
                            data.link = diff.document.get("link") as! String
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
