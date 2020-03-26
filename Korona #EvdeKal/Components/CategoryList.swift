//
//  CategoryList.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 21.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI

struct CategoriesList: View {
    @State var selectedCategory: Int = 0
    var categories: Array = ["Meydan Okuma","Film Tavsiyeleri","Playlistler","Faydalı İçerikler"]
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    var body: some View {
        List {
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 20) {
                    ForEach(categories.indices, id: \.self) { index in
                        Group {
                            if index == self.selectedCategory {
                                VStack(alignment: .center, spacing: 3, content: {
                                    Button(action: {
                                        self.selectedCategory = index
                                    }) {
                                        Text(self.categories[index])
                                    }.foregroundColor(Color(UIColor(named: "DarkColor")!)).font(.system(size: 17, weight: .bold, design: Font.Design.default)).padding(.top, 10)
                                    
                                    Rectangle().frame(width:8, height: 8).foregroundColor(Color(UIColor(named: "DarkColor")!)).cornerRadius(4)
                                })
                            }else {
                                Button(action: {
                                    self.selectedCategory = index
                                }) {
                                    Text(self.categories[index])
                                }.foregroundColor(.gray)
                            }
                        }
                    }
                }
            }).id(UUID().uuidString).frame(height: 30)
        }
    }
}

struct CategoriesList_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesList()
    }
}
