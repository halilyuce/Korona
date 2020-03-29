//
//  WelcomeView.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 28.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var session: SessionStore
    @State var email:String = ""
    @State var password:String = ""
    @State var error:String = ""
    
    func signIn(){
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            VStack(spacing:10){
                Text("Hoşgeldiniz!").font(.system(size: 32, weight: .heavy)).padding(.horizontal)
                Text("Forumda yorum yapabilmek veya başlık açabilmek için giriş yapmalısınız").font(.system(size: 18, weight: .medium)).foregroundColor(.gray).padding(.horizontal).multilineTextAlignment(.center)
            }
            VStack(spacing:14){
                TextField("Email Adresiniz", text: $email).padding(12)
                    .background(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 1))
                SecureField("Şifreniz", text: $password).padding(12)
                    .background(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 1))
            }.padding()
            Button(action: signIn) {
                Text("Giriş Yap")
            }.frame(minWidth:0, maxWidth: .infinity)
                .frame(height:50)
                .foregroundColor(.white)
                .font(.system(size: 14, weight:.bold))
                .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGreen), Color.blue]), startPoint: .bottomLeading, endPoint: .topTrailing))
                .cornerRadius(4)
                .padding(.horizontal)
            FBLogin().frame(minWidth:0, maxWidth: .infinity).frame(height:50).padding(.horizontal)
            TWLogin().frame(minWidth:0, maxWidth: .infinity).frame(height:50).padding(.horizontal)
            if (error != ""){
                Text(error).font(.system(size: 14, weight:.semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            Spacer()
            NavigationLink(destination: RegisterView()) {
                HStack{
                    Text("Henüz bir hesabım yok.").font(.system(size: 14, weight: .light)).foregroundColor(Color.gray)
                    Text("Kayıt olmak istiyorum").font(.system(size: 14, weight: .semibold)).foregroundColor(Color(UIColor.systemGreen))
                }
            }
        }.padding()
            .navigationBarTitle(Text("Giriş Yap"), displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: RegisterView(), label: {
                Text("Kayıt Ol")
            }))
    }
}

struct RegisterView: View {
    
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
       @State var email:String = ""
       @State var password:String = ""
       @State var error:String = ""
    
    func signUp(){
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var body: some View {
                VStack{
                    Spacer()
                    VStack(spacing:10){
                        Text("Hesap Oluştur").font(.system(size: 32, weight: .heavy)).padding(.horizontal)
                        Text("Hesabınız yok mu ? Hadi oluşturalım").font(.system(size: 18, weight: .medium)).foregroundColor(.gray).padding(.horizontal)
                    }
                    VStack(spacing:14){
                        TextField("Email Adresiniz", text: $email).padding(12)
                            .background(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 1))
                        SecureField("Şifreniz", text: $password).padding(12)
                            .background(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 1))
                    }.padding()
                    Button(action: signUp) {
                        Text("Kayıt Ol")
                    }.frame(minWidth:0, maxWidth: .infinity)
                        .frame(height:50)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight:.bold))
                        .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGreen), Color.blue]), startPoint: .bottomLeading, endPoint: .topTrailing))
                        .cornerRadius(4)
                        .padding(.horizontal)
                    if (error != ""){
                        Text(error).font(.system(size: 14, weight:.semibold))
                            .foregroundColor(.red)
                            .padding()
                    }
                    Spacer()
                }.padding()
            .navigationBarTitle(Text("Kayıt Ol"), displayMode: .inline)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView().environmentObject(SessionStore())
    }
}
