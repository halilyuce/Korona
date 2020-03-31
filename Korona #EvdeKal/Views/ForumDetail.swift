//
//  ForumDetail.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 29.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//
import SwiftUI
import Firebase
import CodableFirebase

struct ForumDetail: View {
    @EnvironmentObject var session: SessionStore
    var post = Post(dictionary:["id": "", "title": "", "content": "", "comments": [], "date": Timestamp(date:Date())])
    private var db = Firestore.firestore()
    
    @State private var showingError = false
    @State var comment:String = ""
    @State private var offsetValue: CGFloat = 0.0
    
    init(post: Post){
        self.post = post
    }
    
    var body: some View {
        VStack(spacing:0){
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading, spacing: 10){
                Text(post.title).font(.system(size: 21)).fontWeight(.heavy).padding(.top, 30).padding(.horizontal,20).padding(.bottom, 10)
                Text(post.content).padding(.horizontal, 20).fixedSize(horizontal: false, vertical: true)
                HStack{
                    Text("@" + post.user)
                        .fontWeight(.light).foregroundColor(.gray).font(.system(size: 15))
                    Spacer()
                    Text(post.date.dateValue().timeAgoSinceDate())
                        .fontWeight(.light).foregroundColor(.gray).font(.system(size: 15))
                }.padding(.horizontal, 20).padding(.vertical, 10)
            }
            VStack(alignment: .leading, spacing: 10){
                HStack(alignment: .center, spacing: 12){
                    Text("Yorumlar")
                        .fontWeight(.bold).foregroundColor(.gray).padding(.vertical,15).padding(.horizontal, 20)
                    Spacer()
                    Text("\(post.comments.count) Yorum")
                        .fontWeight(.bold).foregroundColor(.gray).padding(.vertical,15).padding(.horizontal, 20)
                }.background(Color(UIColor(named: "SecondaryColor")!))
                ForEach(post.comments, id: \.date){ comment in
                    VStack(spacing:20){
                        HStack(alignment: .top, spacing: 12){
                            ZStack{
                                Rectangle().frame(width: 42, height: 42, alignment: .leading)
                                    .foregroundColor(.clear)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGreen), Color.blue]), startPoint: .bottomLeading, endPoint: .topTrailing))
                                    .cornerRadius(21)
                                Text(comment.user.prefix(1).uppercased()).fontWeight(.bold).font(.system(size: 26)).foregroundColor(.white)
                            }
                            VStack(alignment: .leading, spacing: 10){
                                HStack{
                                    Text("@" + comment.user)
                                        .fontWeight(.light).foregroundColor(.gray).font(.system(size: 15))
                                    Spacer()
                                    Text(comment.date.dateValue().timeAgoSinceDate())
                                        .fontWeight(.light).foregroundColor(.gray).font(.system(size: 15))
                                }
                                Text(comment.content).fixedSize(horizontal: false, vertical: true)
                            }
                        }.padding(.horizontal, 20).padding(.top, 8)
                        Divider()
                    }
                }
            }
        }.modifier(DismissingKeyboard())
            HStack(spacing:20){
                MultilineTextField("Bir şeyler yaz...", text: $comment).padding(10)
                Button(action: sendComment) {
                    Image(systemName: "paperplane").padding(10).offset(x: -10)
                }
                }.background(Color(UIColor(named: "SecondaryColor")!)).keyboardSensible($offsetValue)
        }
        .alert(isPresented: $showingError) {
            Alert(title: Text("Hata"), message: Text("Bir hata meydana geldi, lütfen tekrar deneyin."), primaryButton: .default(Text("Gerek yok!")), secondaryButton: .default(Text("Tekrar Dene"), action: sendComment))
        }
        .navigationBarTitle(Text("Konu Detayı"), displayMode: .inline)
        .navigationBarItems(trailing:
            HStack(alignment: .center, spacing: 25){
                Button(action: {
                }, label: {
                    Image(systemName: "flag")
                })
                Button(action: {
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            }
        )
    }
    
    func sendComment(){
        let model = Comment(dictionary: ["content": comment, "user": (session.session?.email)!, "created_at": Timestamp(date: Date())])
        let docData = try! FirestoreEncoder().encode(model)
        db.collection("konular").document(post.id).updateData([ "comments": FieldValue.arrayUnion([docData]) ]){ err in
                if let err = err {
                    self.showingError = true
                    print("Error writing city to Firestore: \(err)")
                } else {
                    print("Başarıyla eklendi")
                    self.comment = ""
                }
            }
    }
}

struct ForumDetail_Previews: PreviewProvider {
    static var previews: some View {
        ForumDetail(post: Post(dictionary:["id": "", "title": "", "content": "", "comments": [], "date": Timestamp(date:Date())])).environmentObject(SessionStore())
    }
}
