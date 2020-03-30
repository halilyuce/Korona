//
//  TWLogin.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 29.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase


struct TWLogin: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TWLogin>) -> UIButton {
        let button = UIButton()
        button.setTitle("Twitter Login", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(context.coordinator, action: #selector(context.coordinator.buttonPressed(_:)), for: .touchUpInside)
        
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<TWLogin>) {
    }
}

class Coordinator: NSObject {
    var parent: TWLogin
    var provider = OAuthProvider(providerID: "twitter.com")
    
    init(_ parent: TWLogin) {
        self.parent = parent
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        provider.customParameters = [
             "lang": "tr"
             ]
        provider.getCredentialWith(_: nil) { credential, error in
          if error != nil {
            print((error?.localizedDescription)!)
          }
          if credential != nil {
            Auth.auth().signIn(with: credential!) { authResult, error in
              if error != nil {
                print((error?.localizedDescription)!)
              }
            }
          }
        }
        
    }
}
