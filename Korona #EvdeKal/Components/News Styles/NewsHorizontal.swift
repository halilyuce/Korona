//
//  NewsHorizontal.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct NewsHorizontal: View {

@ObservedObject var fbData = firebaseData
@State var isPresented: Bool = false
@State var selectedNews = NewsDetail(title: "", content: "", image: "", video: "")

var body: some View {
    VStack(alignment: .leading, spacing: 20){
        Group{
            if fbData.data.count > 2 {
                HStack(alignment:.top, spacing:20){
                    ForEach(1..<3, id: \.self){ index in
                            VStack(alignment:.leading, spacing:8){
                                ZStack{
                                    WebImage(url: URL(string:self.fbData.data[index].image))
                                        .resizable()
                                        .indicator(.activity)
                                        .animation(.easeInOut(duration: 0.5))
                                        .transition(.fade)
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(8)
                                        .frame(width: (UIScreen.main.bounds.width / 2) - 28 , height: 120)
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
                                }.cornerRadius(8)
                                Text(self.fbData.data[index].category).font(.system(size: 12)).fontWeight(.bold)
                                    .padding(.horizontal , 10)
                                    .padding(.vertical , 5)
                                    .background(Color(UIColor(named: "SecondaryColor")!)).cornerRadius(10)
                                Text(self.fbData.data[index].title).font(.system(size: 19)).fontWeight(.bold).lineLimit(.none)
                                Spacer(minLength: 5)
                                Text(self.fbData.data[index].created_at.dateValue().timeAgoSinceDate()).font(.system(size: 12)).fontWeight(.bold).foregroundColor(.gray)
                            }.onTapGesture {
                                self.selectedNews = NewsDetail(title: self.fbData.data[index].title, content: self.fbData.data[index].description, image: self.fbData.data[index].image, video: self.fbData.data[index].video)
                                self.isPresented.toggle()
                            }
                    }
                }.frame(height:270)
            }else{
                EmptyView()
            }
        }
    Divider()
    }
    .sheet(isPresented: $isPresented) {
        self.selectedNews
    }
}
}

struct NewsHorizontal_Previews: PreviewProvider {
    static var previews: some View {
        NewsHorizontal()
    }
}

