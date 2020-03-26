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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Group{
                if fbData.data.count > 4 {
                    VStack(alignment:.leading){
                        HStack(alignment:.top, spacing:20){
                            Group{
                                ZStack{
                                    WebImage(url: URL(string: fbData.data[3].image))
                                        .resizable()
                                        .indicator(.activity)
                                        .animation(.easeInOut(duration: 0.5))
                                        .transition(.fade)
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(8)
                                        .frame(width: UIScreen.main.bounds.width / 3 , height: 132)
                                        .clipped()
                                    Group{
                                        if fbData.data[3].video != "" {
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
                                Text(fbData.data[3].category).font(.system(size: 12)).fontWeight(.bold)
                                    .padding(.horizontal , 10)
                                    .padding(.vertical , 5)
                                    .background(Color(UIColor(named: "SecondaryColor")!)).cornerRadius(10)
                                Text(fbData.data[3].title).font(.system(size: 19)).fontWeight(.bold)
                                Spacer(minLength: 5)
                                Text(fbData.data[3].created_at.dateValue().timeAgoSinceDate()).font(.system(size: 12)).fontWeight(.bold).foregroundColor(.gray)
                            }.frame(height:132)
                        }
                        NavigationLink(destination: NewsDetail(title: fbData.data[3].title, content: fbData.data[3].description, image: fbData.data[3].image, video: fbData.data[3].video)){
                            EmptyView()
                        }
                    }
                    VStack(alignment:.leading){
                        HStack(alignment:.top, spacing:20){
                            ZStack{
                                WebImage(url: URL(string: fbData.data[4].image))
                                    .resizable()
                                    .indicator(.activity)
                                    .animation(.easeInOut(duration: 0.5))
                                    .transition(.fade)
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(8)
                                    .frame(width: UIScreen.main.bounds.width / 3 , height: 132)
                                    .clipped()
                                Group{
                                    if fbData.data[4].video != "" {
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
                            VStack(alignment: .leading, spacing: 5){
                                Text(fbData.data[4].category).font(.system(size: 12)).fontWeight(.bold)
                                    .padding(.horizontal , 10)
                                    .padding(.vertical , 5)
                                    .background(Color(UIColor(named: "SecondaryColor")!)).cornerRadius(10)
                                Text(fbData.data[4].title).font(.system(size: 19)).fontWeight(.bold)
                                Spacer(minLength: 5)
                                Text(fbData.data[4].created_at.dateValue().timeAgoSinceDate()).font(.system(size: 12)).fontWeight(.bold).foregroundColor(.gray)
                            }.frame(height:132)
                        }.padding(.bottom)
                        NavigationLink(destination: NewsDetail(title: fbData.data[4].title, content: fbData.data[4].description, image: fbData.data[4].image, video: fbData.data[4].video)){
                            EmptyView()
                        }
                    }
                }else{
                    EmptyView()
                }
            }
        }
    }
}


struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList()
    }
}

