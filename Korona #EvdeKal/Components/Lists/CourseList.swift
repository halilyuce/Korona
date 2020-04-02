//
//  CourseList.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    
    @ObservedObject var fbCourse = firebaseCourses
    @State var isClicked:Bool = false
    @State var clickedUrl: String = ""
    
    var body: some View {
        VStack(alignment:.leading, spacing: 20) {
           Text("Kişisel Gelişim").font(.title).fontWeight(.black)
            ForEach(fbCourse.data, id: \.id) { course in
                VStack(alignment:.leading){
                    HStack(alignment:.top, spacing:18){
                        Group{
                            WebImage(url: URL(string: course.image))
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
                            Text(course.type).font(.system(size: 12)).fontWeight(.bold)
                                .padding(.horizontal , 10)
                                .padding(.vertical , 5)
                                .background(Color(UIColor(named: "SecondaryColor")!)).cornerRadius(10)
                            Text(course.title).font(.system(size: 19)).fontWeight(.bold)
                            Spacer(minLength: 5)
                        }.frame(height:132)
                    }.padding(.bottom, 10)
                        .onTapGesture {
                            self.isClicked.toggle()
                            self.clickedUrl = course.link
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

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}
