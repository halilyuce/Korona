//
//  FBLogin.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 29.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import FBSDKLoginKit
import Firebase

struct FBLogin: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return FBLogin.Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<FBLogin>) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = ["email"]
        button.delegate = context.coordinator
        return button
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FBLogin>) {
        
    }
    
    class Coordinator: NSObject,LoginButtonDelegate{
        
        @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if error != nil {
                print((error?.localizedDescription)!)
            }
            if AccessToken.current != nil {
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                Auth.auth().signIn(with: credential) { (res, err) in
                    if err != nil{
                        print((err?.localizedDescription)!)
                        return
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
        }
        
        
    }
    
}
