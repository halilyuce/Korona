//
//  OpportunitiesList.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 1.04.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct OpportunitiesList: View {
    
    @ObservedObject var fbOpportunities = firebaseOpportunities
    @State var isClicked:Bool = false
    @State var clickedUrl: String = ""
    
    var body: some View {
        VStack(alignment:.leading, spacing: 20) {
           Text("Fırsatlar & Kampanyalar").font(.title).fontWeight(.black)
            ForEach(fbOpportunities.data, id: \.id) { opportunity in
                VStack(alignment:.leading){
                    HStack(alignment:.top, spacing:18){
                        Group{
                            WebImage(url: URL(string: opportunity.image))
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
                            Text(opportunity.type).font(.system(size: 12)).fontWeight(.bold)
                                .padding(.horizontal , 10)
                                .padding(.vertical , 5)
                                .background(Color(UIColor(named: "SecondaryColor")!)).cornerRadius(10)
                            Text(opportunity.title).font(.system(size: 19)).fontWeight(.bold)
                            Spacer(minLength: 5)
                            Group{
                                if opportunity.code != ""{
                                    Text("Kupon Kodu: " + opportunity.code).font(.system(size: 12)).fontWeight(.bold).foregroundColor(.gray)
                                }else{
                                    Text("Faydalanmak için tıklayınız").font(.system(size: 12)).fontWeight(.bold).foregroundColor(.gray)
                                }
                            }
                        }.frame(height:132)
                    }.padding(.bottom, 10)
                        .onTapGesture {
                            self.isClicked.toggle()
                            self.clickedUrl = opportunity.link
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

struct OpportunitiesList_Previews: PreviewProvider {
    static var previews: some View {
        OpportunitiesList()
    }
}

