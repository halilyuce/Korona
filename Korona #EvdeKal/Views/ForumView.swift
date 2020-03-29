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
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20){
                    Text("Şuan için içerik bulunmamaktadır").padding()
                    Spacer()
                }
            }
            .navigationBarTitle(Text("Forum"))
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
