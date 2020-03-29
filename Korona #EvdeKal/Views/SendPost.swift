//
//  SendPost.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 28.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI

struct SendPost: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
                VStack(alignment: .leading, spacing: 20){
                    Text("\((session.session?.email) ?? "")").padding()
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
}

struct SendPost_Previews: PreviewProvider {
    static var previews: some View {
        SendPost().environmentObject(SessionStore())
    }
}
