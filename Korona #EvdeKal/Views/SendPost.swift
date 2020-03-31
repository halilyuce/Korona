//
//  SendPost.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 28.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import CodableFirebase

struct SendPost: View {
    @EnvironmentObject var session: SessionStore
    private var db = Firestore.firestore()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var title:String = ""
    @State var content:String = ""
    var id:String = UUID().uuidString
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 20){
                VStack(spacing:14){
                    TextField("Başlık", text: $title)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 4).stroke(Color(UIColor.separator), lineWidth: 1))
                    MultilineTextField("Bir şeyler yazın", text: $content)
                        .padding(6)
                        .background(RoundedRectangle(cornerRadius: 4).stroke(Color(UIColor.separator), lineWidth: 1))
                }.padding()
            }
            Button(action: createPost) {
                Text("Oluştur")
            }.frame(minWidth:0, maxWidth: .infinity)
                .frame(height:50)
                .foregroundColor(.white)
                .font(.system(size: 14, weight:.bold))
                .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGreen), Color.blue]), startPoint: .bottomLeading, endPoint: .topTrailing))
                .cornerRadius(4)
                .padding(.horizontal)
            Spacer()
        }
        .navigationBarTitle(Text("Konu Aç"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.session.signOut()
            }, label: {
                Text("Çıkış Yap")
            })
        )
    }
    
    func createPost() {
        let model = Post(dictionary: ["id": id, "title": title, "content": content, "comments": [], "user": (session.session?.email)!, "date": Timestamp(date:Date())])
        let docData = try! FirestoreEncoder().encode(model)
        db.collection("konular").document(self.id).setData(docData) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Başarıyla eklendi")
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct SendPost_Previews: PreviewProvider {
    static var previews: some View {
        SendPost().environmentObject(SessionStore())
    }
}
