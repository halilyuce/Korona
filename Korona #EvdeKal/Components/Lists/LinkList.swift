//
//  LinkList.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct LinkList: View {
    
    @ObservedObject var fbLink = firebaseLinks
    @State var isClicked:Bool = false
    @State var clickedUrl: String = ""
    
    var body: some View {
        VStack(alignment:.leading, spacing: 20) {
           Text("Faydalı Linkler").font(.title).fontWeight(.black)
            ForEach(fbLink.data, id: \.id) { link in
                VStack(alignment:.leading){
                    HStack(alignment:.top, spacing:17){
                        Group{
                            WebImage(url: URL(string: link.image))
                                .resizable()
                                .indicator(.activity)
                                .animation(.easeInOut(duration: 0.5))
                                .transition(.fade)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(8)
                                .frame(width: UIScreen.main.bounds.width / 4 , height: 132)
                                .clipped()
                        }.cornerRadius(8)
                        VStack(alignment: .leading, spacing: 5){
                            Text(link.type).font(.system(size: 12)).fontWeight(.bold)
                                .padding(.horizontal , 10)
                                .padding(.vertical , 5)
                                .background(Color(UIColor(named: "SecondaryColor")!)).cornerRadius(10)
                            Text(link.title).font(.system(size: 19)).fontWeight(.bold)
                            Text(link.description).font(.system(size: 15)).foregroundColor(.gray)
                            Spacer(minLength: 5)
                        }.frame(height:132)
                    }.padding(.bottom, 10)
                        .onTapGesture {
                            self.isClicked.toggle()
                            self.clickedUrl = link.link
                    }
                    Divider()
                }
                
            }
            .sheet(isPresented: $isClicked) {
                SafariView(url:URL(string: self.clickedUrl)!)
            }
        }.padding(.vertical)
    }
}

struct LinkList_Previews: PreviewProvider {
    static var previews: some View {
        LinkList()
    }
}
