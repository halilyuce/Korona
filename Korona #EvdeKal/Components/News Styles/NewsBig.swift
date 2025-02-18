//
//  NewsBig.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct NewsBig: View {

@ObservedObject var fbData = firebaseData
@State var isPresented: Bool = false
@State var selectedNews = NewsDetail(title: "", content: "", image: "", video: "")

var body: some View {
    VStack(alignment: .leading, spacing: 20){
    Group{
        if fbData.data.count > 0 {
                VStack(alignment: .leading, spacing: 20){
                    Text("🧑🏻‍⚕️ İçerikler").font(.title).fontWeight(.black)
                    ZStack{
                        WebImage(url: URL(string:fbData.data[0].image))
                            .resizable()
                            .indicator(.activity)
                            .animation(.easeInOut(duration: 0.5))
                            .transition(.fade)
                            .scaledToFit()
                            .cornerRadius(8)
                        Group{
                            if fbData.data[0].video != "" {
                                Image(systemName: "play.fill")
                                    .font(.largeTitle)
                                    .background(Circle()
                                        .fill(Color.black.opacity(0.6)).frame(width: 64, height: 64, alignment: .center))
                                    .foregroundColor(.white)
                                    .padding(20)
                            }else{
                                EmptyView()
                            }
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width - 38)
                    VStack(alignment:.leading, spacing:5){ Text(fbData.data[0].category).font(.system(size: 12)).fontWeight(.bold)
                        .padding(.horizontal , 10)
                        .padding(.vertical , 5)
                        .background(Color(UIColor(named: "SecondaryColor")!)).cornerRadius(10)
                        Text(fbData.data[0].title).font(.system(size: 24)).fontWeight(.bold)
                    }
                }.onTapGesture {
                    self.selectedNews = NewsDetail(title: self.fbData.data[0].title, content: self.fbData.data[0].description, image: self.fbData.data[0].image, video: self.fbData.data[0].video)
                    self.isPresented.toggle()
                }
        }else {
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

struct NewsBig_Previews: PreviewProvider {
    static var previews: some View {
        NewsBig()
    }
}

