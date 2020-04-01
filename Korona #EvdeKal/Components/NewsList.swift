//
//  NewsList.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct NewsList: View {
    
    @ObservedObject var fbData = firebaseData
    @State var selection: String? = ""
    @State var isPresented: Bool = false
    @State var selectedNews = NewsDetail(title: "", content: "", image: "", video: "")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Group{
                if fbData.data.count > 4 {
                    ForEach(3..<5, id: \.self){ index in
                        HStack(alignment:.top, spacing:20){
                            Group{
                                ZStack{
                                    WebImage(url: URL(string: self.fbData.data[index].image))
                                        .resizable()
                                        .indicator(.activity)
                                        .animation(.easeInOut(duration: 0.5))
                                        .transition(.fade)
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(8)
                                        .frame(width: UIScreen.main.bounds.width / 3 , height: 132)
                                        .clipped()
                                    Group{
                                        if self.fbData.data[index].video != "" {
                                            Image(systemName: "play.fill")
                                                .font(.headline)
                                                .background(Circle()
                                                    .fill(Color.black.opacity(0.6)).frame(width: 48, height: 48, alignment: .center))
                                                .foregroundColor(.white)
                                                .padding(20)
                                        }else{
                                            EmptyView()
                                        }
                                    }
                                }
                            }.cornerRadius(8)
                            VStack(alignment: .leading, spacing: 5){
                                Text(self.fbData.data[index].category).font(.system(size: 12)).fontWeight(.bold)
                                    .padding(.horizontal , 10)
                                    .padding(.vertical , 5)
                                    .background(Color(UIColor(named: "SecondaryColor")!)).cornerRadius(10)
                                Text(self.fbData.data[index].title).font(.system(size: 19)).fontWeight(.bold)
                                Spacer(minLength: 5)
                                Text(self.fbData.data[index].created_at.dateValue().timeAgoSinceDate()).font(.system(size: 12)).fontWeight(.bold).foregroundColor(.gray)
                            }.frame(height:132)
                        }.onTapGesture {
                            self.selectedNews = NewsDetail(title: self.fbData.data[index].title, content: self.fbData.data[index].description, image: self.fbData.data[index].image, video: self.fbData.data[index].video)
                            self.isPresented.toggle()
                        }
                    }
                }else{
                    EmptyView()
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            self.selectedNews
        }
    }
}


struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList()
    }
}

