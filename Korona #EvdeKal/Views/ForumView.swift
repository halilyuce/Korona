//
//  ForumView.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI

struct ForumView: View {
    @EnvironmentObject var session: SessionStore
    @State var isLogin:Bool = false
    @ObservedObject var fbData = firebasePosts
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        NavigationView {
            List(fbData.data, id: \.id){ post in
                NavigationLink(destination: ForumDetail(post: post)) {
                        VStack(alignment: .leading, spacing: 5){
                            HStack{
                                Text("@" + post.user)
                                    .fontWeight(.light).foregroundColor(.gray).font(.system(size: 15))
                                Spacer()
                                Text(post.date.dateValue().timeAgoSinceDate())
                                    .fontWeight(.light).foregroundColor(.gray).font(.system(size: 15))
                            }.padding(.bottom, 5)
                            Text(post.title).fontWeight(.semibold).padding(.bottom, 10)
                            Divider()
                        }
                    }
            }
            .navigationBarTitle(Text("Başlıklar"))
            .navigationBarItems(trailing:
                NavigationLink(destination:Group {
                    if (self.session.session != nil){
                        SendPost()
                    }else {
                        WelcomeView()
                    }
                }) {
                    Text("Konu Aç")
                }.onAppear(perform: getUser)
            )
        }
    }
}

struct ForumView_Previews: PreviewProvider {
    static var previews: some View {
        ForumView().environmentObject(SessionStore())
    }
}
