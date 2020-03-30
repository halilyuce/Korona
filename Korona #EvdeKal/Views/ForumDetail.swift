//
//  ForumDetail.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 29.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//
import SwiftUI
import Firebase

struct ForumDetail: View {
    @EnvironmentObject var session: SessionStore
    var post = Post(id: "", title: "", content: "", user: "", comments: [], created_at: Timestamp(date: Date()))
    @State var comment:String = ""
    @State private var offsetValue: CGFloat = 0.0
    
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
                    Text(post.created_at.dateValue().timeAgoSinceDate())
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
                ForEach(post.comments, id: \.body){ comment in
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
                                    Text(comment.created_at.dateValue().timeAgoSinceDate())
                                        .fontWeight(.light).foregroundColor(.gray).font(.system(size: 15))
                                }
                                Text(comment.body).fixedSize(horizontal: false, vertical: true)
                            }
                        }.padding(.horizontal, 20).padding(.top, 8)
                        Divider()
                    }
                }
            }
        }.modifier(DismissingKeyboard())
            HStack(spacing:20){
                MultilineTextField("Bir şeyler yaz...", text: $comment).padding(10)
                Image(systemName: "paperplane").padding(10).offset(x: -10)
                }.background(Color(UIColor(named: "SecondaryColor")!)).keyboardSensible($offsetValue)
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
}

struct ForumDetail_Previews: PreviewProvider {
    static var previews: some View {
        ForumDetail().environmentObject(SessionStore())
    }
}
