//
//  FirebaseFilms.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import FirebaseFirestore

let dbCollectionFilms = Firestore.firestore().collection("filmler")
let firebaseFilms = FirebaseFilms()

class FirebaseFilms: ObservableObject {
    
    @Published var data = [Films]()
    
    init() {
        readData()
    }
    
    func readData() {
        dbCollectionFilms.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    let msgData = Films(id: diff.document.documentID, title: diff.document.get("title") as! String, kind: diff.document.get("kind") as! String, type: diff.document.get("type") as! String, imdb: diff.document.get("imdb") as! Double, image: diff.document.get("image") as! String, link: diff.document.get("link") as! String, year: diff.document.get("year") as! String)
                    self.data.append(msgData)
                }
                
                // Real time modify from server
                if (diff.type == .modified) {
                    self.data = self.data.map { (eachData) -> Films in
                        var data = eachData
                        if data.id == diff.document.documentID {
                            data.title = diff.document.get("title") as! String
                            data.kind = diff.document.get("kind") as! String
                            data.image = diff.document.get("image") as! String
                            data.imdb = diff.document.get("imdb") as! Double
                            data.link = diff.document.get("link") as! String
                            data.year = diff.document.get("year") as! String
                            data.type = diff.document.get("type") as! String
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
