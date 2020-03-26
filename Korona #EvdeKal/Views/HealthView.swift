//
//  NewsView.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 20.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct HealthView: View {
    
    @ObservedObject var fbCovid = firebaseCovid
    
    init(){
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorColor = .clear
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            List{
                Group{
                    if fbCovid.data.count > 0 {
                        VStack(alignment:.leading){
                            HStack(spacing:20){
                                Text("COVID-19 hakkında detaylı bilgiler ve Sıkça Sorulan Sorular için tıklayınız.")
                                    .lineLimit(nil)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                    .padding(10)
                                Spacer(minLength: 5)
                                Image(systemName: "chevron.right")
                                    .frame(width:40)
                                    .foregroundColor(.white)
                            }.background(Color(UIColor(named: "Green")!))
                                .cornerRadius(8)
                                .frame(height:70)
                        NavigationLink(destination: NewsDetail(title: fbCovid.data[0].title, content: fbCovid.data[0].content, image: fbCovid.data[0].image, video: "")) {
                                EmptyView()
                        }
                        }
                    }else {
                        EmptyView()
                    }
                }
                NewsBig()
                NewsHorizontal()
                NewsList()
                StepbyStep().listRowBackground(Color(UIColor(named: "LightBackground")!)).padding(.vertical)
                NewsView()
            }
            .navigationBarTitle(Text("Sağlık"))
            .navigationBarItems(trailing:
                Button(action: {
                }, label: {
                    Button(action: {
                        let number = "184"
                        let dash = CharacterSet(charactersIn: "-")
                        let cleanString = number.trimmingCharacters(in: dash)
                        let tel = "tel://"
                        let formattedString = tel + cleanString
                        let url: NSURL = URL(string: formattedString)! as NSURL
                        
                        UIApplication.shared.open(url as URL)
                    }) {
                        Text("Alo 184")
                    }
                })
            )
        }
    }
}

struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
    }
}
