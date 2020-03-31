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
import PartialSheet
import UserNotifications

struct HealthView: View {
    
    @ObservedObject var fbCovid = firebaseCovid
    
    @State var isEnabledNotify: Bool = UserDefaults.standard.bool(forKey: "localNotify")
    @State var startTime: Date = UserDefaults.standard.object(forKey: "startTime") as? Date ?? Date()
    @State var endTime: Date = UserDefaults.standard.object(forKey: "endTime") as? Date ?? Date().addingTimeInterval(3600)
    @State var isShowStart:Bool = false
    @State var isShowEnd:Bool = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var titles: [String] = ["Ellerini Yıkama Vaktin Geldi 👐🏻", "Ellerini Yıkıyorsundur Umarım 🙄", "Hey, Hadi Ellerini Yıka ✋🏻", "Vakit Geldi, Hadi Lavaboya 🏃🏻‍♀️💨"]
    var contents: [String] = ["Ellerini yıkamanın virüsden korunmak için ne kadar önemli olduğunu unutma, üşenme 🐨", "Ellerini yıkıyarak sadece kendini değil çevrendeki insanları da korumuş olursun 😇", "Bir sürü yere dokundun, dezenfekte olma vakti geldi 🤷🏻‍♂️", "Ellerini yıkamayı erteleme, birazdan dersen gitmeyeceğini ikimiz de biliyoruz 🤦🏻‍♂️ Haydi kalk 😬"]
    
    init(){
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorColor = .clear
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    func toggleAction(state: String) -> String {
        if state == "Checked"{
            UserDefaults.standard.set(true, forKey: "localNotify")
            createNotify()
        }else {
            UserDefaults.standard.set(false, forKey: "localNotify")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["washHands"])
        }
        return ""
    }
    
    func createNotify(){
        let content = UNMutableNotificationContent()
        content.title = self.titles.randomElement()!
        content.body = self.contents.randomElement()!
        content.sound = UNNotificationSound.default
        
        let date = self.startTime
        let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let request = UNNotificationRequest(identifier:"washHands", content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
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
                
                VStack(alignment:.leading, spacing: 20) {
                    Text("✋🏻 Ellerinizi Yıkayın").font(.title).fontWeight(.black)
                    List{
                        Toggle(isOn: self.$isEnabledNotify) {
                            Text("Hatırlatıcı Bildirimler")
                            if (self.isEnabledNotify) {
                                Text("\(self.toggleAction(state: "Checked"))")
                            } else {
                                Text("\(self.toggleAction(state: "Unchecked"))")
                            }
                        }
                        HStack{
                            Button(action: {
                                self.isShowStart = true
                            }) {
                                Text("Başlangıç Saati")
                            }
                            Spacer()
                            Text("\(startTime, formatter: dateFormatter)")
                        }
                        HStack{
                            Button(action: {
                                self.isShowEnd = true
                            }) {
                                Text("Bitiş Saati")
                            }
                            Spacer()
                            Text("\(endTime, formatter: dateFormatter)")
                        }
                }.frame(width: UIScreen.main.bounds.width, height: 150, alignment: .leading).padding(.leading, -20)
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
        .partialSheet(presented: $isShowStart, backgroundColor: Color(UIColor(named: "LightBackground")!), enableCover: true, coverColor: Color.black.opacity(0.4)) {
            VStack{
                DatePicker(selection: self.$startTime, displayedComponents: .hourAndMinute) {
                    EmptyView()
                }.labelsHidden()
                Button(action: {
                    UserDefaults.standard.set(self.startTime, forKey: "startTime")
                    self.isShowStart = false
                }) {
                    Text("Seç")
                }.frame(minWidth:0, maxWidth: .infinity)
                    .frame(height:50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight:.bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGreen), Color.blue]), startPoint: .bottomLeading, endPoint: .topTrailing))
                    .cornerRadius(4)
                    .padding(.horizontal)
            }
        }
        .partialSheet(presented: $isShowEnd, backgroundColor: Color(UIColor(named: "LightBackground")!), enableCover: true, coverColor: Color.black.opacity(0.4)) {
            VStack{
                DatePicker(selection: self.$endTime, in: self.startTime..., displayedComponents: .hourAndMinute) {
                    EmptyView()
                }.labelsHidden()
                Button(action: {
                    UserDefaults.standard.set(self.endTime, forKey: "endTime")
                    self.isShowEnd = false
                }) {
                    Text("Seç")
                }.frame(minWidth:0, maxWidth: .infinity)
                    .frame(height:50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight:.bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGreen), Color.blue]), startPoint: .bottomLeading, endPoint: .topTrailing))
                    .cornerRadius(4)
                    .padding(.horizontal)
            }
        }
    }
}

struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
    }
}
