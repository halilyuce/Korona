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
                Button(action: {
                }, label: {
                    Text("Konu Aç")
                })
            )
        }
    }
}

struct ForumView_Previews: PreviewProvider {
    static var previews: some View {
        ForumView()
    }
}
