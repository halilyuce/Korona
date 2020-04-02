//
//  NewsDetail.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct NewsDetail: View {
    
    var title:String = ""
    var content:String = ""
    var image:String = ""
    var video:String = ""
    var attr = NSAttributedString()
    var imageShare = UIImageView()
    @State private var showShareSheet = false
    let screenWidth = UIScreen.main.bounds.width
    let formatString = "<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size:17\">%@</span>"
    
    init(title:String,content:String,image:String,video:String){
        self.content = content
        self.title = title
        self.image = image
        self.video = video
        self.imageShare.downloaded(from: image)
        
        self.attr = String(format:self.formatString, content).convertHtml()
        
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 20){
                Group{
                    if self.video != ""{
                        YoutubePlayer(videoID: video).frame(height:210)
                    }else {
                        WebImage(url: URL(string:image))
                            .resizable()
                            .indicator(.activity)
                            .animation(.easeInOut(duration: 0.5))
                            .transition(.fade)
                            .aspectRatio(contentMode: .fill)
                            .frame(width:screenWidth, height: 250)
                            .clipped()
                    }
                }
                Text(title).fontWeight(.bold).lineLimit(.none).padding(.horizontal).font(.title)
            }
            TextWithAttributedString(html: String(format:formatString, content)).padding(.horizontal).frame(width: screenWidth, height: attr.textHeightFrom(width: self.screenWidth - 32, font: UIFont.systemFont(ofSize: 17)))
            Divider()
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [self.imageShare.image!, self.title])
        }
        .navigationBarTitle(Text(title), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
            }, label: {
                Button(action: {
                    self.showShareSheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            })
        )
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail(title: "", content: "", image: "", video: "")
    }
}
