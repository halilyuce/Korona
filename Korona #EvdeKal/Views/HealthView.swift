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
import UserNotifications

struct HealthView: View {
    
    @State var isEnabledNotify: Bool = UserDefaults.standard.bool(forKey: "localNotify")
    @State var startTime: Date = UserDefaults.standard.object(forKey: "startTime") as? Date ?? Date()
    @State var endTime: Date = UserDefaults.standard.object(forKey: "endTime") as? Date ?? Date().addingTimeInterval(3600)
    @State var isShow:Bool = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var titles: [String] = ["Ellerini Yıkama Vaktin Geldi 👐🏻", "Ellerini Yıkıyorsundur Umarım 🙄", "Hey, Haydi Ellerini Yıka ✋🏻", "Vakit Geldi, Haydi Lavaboya 🏃🏻‍♀️💨"]
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
        let now = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let nowHour:Int = calendar.component(.hour, from: now)
        let endHour:Int = calendar.component(.hour, from: endTime)
        
        if nowHour <= endHour{
            let content = UNMutableNotificationContent()
            content.title = titles.randomElement()!
            content.body = contents.randomElement()!
            content.sound = UNNotificationSound.default
            
            let interval:TimeInterval = 3600.0 // 1 minute = 60 seconds
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
            let request = UNNotificationRequest(identifier:"washHands", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }else{
            print("do nothing")
        }
    }
    
    var body: some View {
        NavigationView {
            List{
                    HStack(spacing:20){
                        Text("Twitter ve Instagram Hesaplarımız : @evdekalapp")
                            .lineLimit(nil)
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                            .padding(10)
                            .padding(.leading, 5)
                        Spacer(minLength: 5)
                        Image(systemName: "person.crop.circle")
                            .frame(width:40)
                            .foregroundColor(.white)
                            .padding(.trailing, 5)
                        }
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .bottomLeading, endPoint: .topTrailing))
                        .cornerRadius(8)
                        .frame(height:70)
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
                                self.isShow = true
                            }) {
                                Text("Başlangıç Saati")
                            }
                            Spacer()
                            Text("\(startTime, formatter: dateFormatter)")
                        }
                        HStack{
                            Button(action: {
                                self.isShow = true
                            }) {
                                Text("Bitiş Saati")
                            }
                            Spacer()
                            Text("\(endTime, formatter: dateFormatter)")
                        }
                    }.frame(width: UIScreen.main.bounds.width - 6, height: 150, alignment: .leading).padding(.leading, -12)
                }
                NewsBig()
                NewsHorizontal().padding(.top, 5)
                NewsList().padding(.bottom).padding(.top, 5)
                StepbyStep().listRowBackground(Color(UIColor(named: "SecondaryColor")!)).padding(.vertical)
                NewsView()
            }
                .sheet(isPresented: $isShow) {
                    VStack{
                        Text("Başlangıç Saati").font(.title).fontWeight(.black)
                        DatePicker(selection: self.$startTime, displayedComponents: .hourAndMinute) {
                            EmptyView()
                        }.labelsHidden()
                        Text("Bitiş Saati").font(.title).fontWeight(.black)
                        DatePicker(selection: self.$endTime, in: self.startTime..., displayedComponents: .hourAndMinute) {
                            EmptyView()
                        }.labelsHidden()
                        Button(action: {
                            UserDefaults.standard.set(self.startTime, forKey: "startTime")
                            UserDefaults.standard.set(self.endTime, forKey: "endTime")
                            self.isShow = false
                        }) {
                            Text("Seç")
                        }.frame(minWidth:0, maxWidth: .infinity)
                            .frame(height:50)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight:.bold))
                            .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGreen), Color.blue]), startPoint: .bottomLeading, endPoint: .topTrailing))
                            .cornerRadius(4)
                            .padding(.horizontal).padding(.bottom, 30)
                    }
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
