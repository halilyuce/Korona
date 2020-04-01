//
//  CategorySegment.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CategorySelect: ObservableObject {
    @Published var selected: Int = 0
}

struct CategorySegment: View {
    
    @ObservedObject var selectedCategory: CategorySelect
    
    var array:Array = ["film","book","music.note.list","gamecontroller","calendar","tag","globe","studentdesk","person"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(array.indices, id: \.self){ index in
                    Button(action: {
                        self.selectedCategory.selected = index
                    }, label: {
                        if index == self.selectedCategory.selected {
                            VStack(alignment: .center, spacing: 0){
                                Image(systemName: self.array[index])
                                    .frame(width: 48, height: 48)
                                    .font(.system(size: 21))
                                    .padding(.top, 5)
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 6, height: 6 ,alignment: .bottom)
                            }
                            .padding(.horizontal)
                            .padding(.vertical,10)
                            .background(Color(UIColor(named: "LightBackground")!))
                            .cornerRadius(20)
                            .shadow(color: Color(UIColor.separator).opacity(0.25), radius: 12, x: 0, y: 8)
                        }else {
                            Image(systemName: self.array[index]).frame(width: 48, height: 48)
                                .font(.system(size: 21))
                                .foregroundColor(.secondary)
                                .padding()
                        }
                    })
                }
            }
        }.frame(width: UIScreen.main.bounds.width - 12, height: 82)
            .border(Color(UIColor(named: "SecondaryColor")!), width: 1)
            .cornerRadius(20, corners: [.topLeft, .bottomLeft])
    }
}
struct CategorySegment_Previews: PreviewProvider {
    static var previews: some View {
        CategorySegment(selectedCategory: CategorySelect.init())
    }
}
