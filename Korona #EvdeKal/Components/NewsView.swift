//
//  NewsView.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import SafariServices

struct NewsView: View {
    
    @ObservedObject var viewModel = NewsVM()
    @State var isClicked:Bool = false
    @State var clickedUrl: String = ""
    
    func dateConvert(dateString: String) -> String{
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds]
        let date = isoDateFormatter.date(from: dateString)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date!)
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: 20) {
           Text("📰 Haberler").font(.title).fontWeight(.black)
            ForEach(viewModel.news, id: \.name) { new in
                VStack(alignment:.leading){
                    HStack(alignment:.top, spacing:20){
                        Group{
                            WebImage(url: URL(string: new.image))
                                .resizable()
                                .indicator(.activity)
                                .animation(.easeInOut(duration: 0.5))
                                .transition(.fade)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(8)
                                .frame(width: UIScreen.main.bounds.width / 3 , height: 132)
                                .clipped()
                        }.cornerRadius(8)
                        VStack(alignment: .leading, spacing: 5){
                            Text(new.source).font(.system(size: 12)).fontWeight(.bold)
                                .padding(.horizontal , 10)
                                .padding(.vertical , 5)
                                .background(Color(UIColor(named: "SecondaryColor")!)).cornerRadius(10)
                            Text(new.name).font(.system(size: 19)).fontWeight(.bold)
                            Spacer(minLength: 5)
                            Text(self.dateConvert(dateString: new.date)).font(.system(size: 12)).fontWeight(.bold).foregroundColor(.gray)
                        }.frame(height:132)
                    }.padding(.bottom, 10)
                        .onTapGesture {
                            self.isClicked.toggle()
                            self.clickedUrl = new.url
                    }
                    Divider()
                }
                
            }
            .sheet(isPresented: $isClicked) {
                SafariView(url:URL(string: self.clickedUrl)!)
            }
            .alert(isPresented: $viewModel.alert) {
                Alert(title: Text("Bir Hata Meydana Geldi"), message: Text("Görünüşe göre internet bağlantınızdan veya servislerimizden kaynaklı bir hata meydana geldi. Lütfen tekrar deneyiniz."), dismissButton: .default(Text("Tekrar Dene!")){
                    self.viewModel.fetchNews()
                    })
            }
        }.padding(.vertical)
    }
}

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url, entersReaderIfAvailable: true)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
    
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

