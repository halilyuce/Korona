//
//  FirebaseGames.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import FirebaseFirestore

let dbCollectionGames = Firestore.firestore().collection("oyunlar")
let firebaseGames = FirebaseGames()

class FirebaseGames: ObservableObject {
    
    @Published var data = [Games]()
    
    init() {
        readData()
    }
    
    func readData() {
        dbCollectionGames.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    let msgData = Games(id: diff.document.documentID, title: diff.document.get("title") as! String, image: diff.document.get("image") as! String, link: diff.document.get("link") as! String, price: diff.document.get("price") as! String, type: diff.document.get("type") as! String)
                    self.data.append(msgData)
                }
                
                // Real time modify from server
                if (diff.type == .modified) {
                    self.data = self.data.map { (eachData) -> Games in
                        var data = eachData
                        if data.id == diff.document.documentID {
                            data.title = diff.document.get("title") as! String
                            data.type = diff.document.get("type") as! String
                            data.image = diff.document.get("image") as! String
                            data.price = diff.document.get("price") as! String
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
