//
//  SessionStore.swift
//  Evde Kal
//
//  Created by Halil İbrahim YÜCE on 28.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestoreSwift

struct UserProfile: Codable {
  var uid: String
  var email: String?
}

class UserProfileRepository: ObservableObject {
  private var db = Firestore.firestore()

  func createProfile(profile: UserProfile, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    do {
      let _ = try db.collection("users").document(profile.uid).setData(from: profile)
      completion(profile, nil)
    }
    catch let error {
      print("Error writing city to Firestore: \(error)")
      completion(nil, error)
    }
  }

  func fetchProfile(userId: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    db.collection("users").document(userId).getDocument { (snapshot, error) in
      let profile = try? snapshot?.data(as: UserProfile.self)
      completion(profile, error)
    }
  }
}

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? {didSet {self.didChange.send(self)} }
    @Published var profile: UserProfile? {didSet {self.didChange.send(self)} }
    private var profileRepository = UserProfileRepository()
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen(){
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, email: user.email)
                self.profile = UserProfile(uid: user.uid, email: user.email)
            } else {
                self.session = nil
            }
        })
    }
    
    func signUp(email:String, password:String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password){ (result, error) in
            if let error = error {
              print("Error signing up: \(error)")
              completion(nil, error)
              return
            }
            
            guard let user = result?.user else { return }
            print("User \(user.uid) signed up.")

            let userProfile = UserProfile(uid: user.uid, email:user.email)
            self.profileRepository.createProfile(profile: userProfile) { (profile, error) in
              if let error = error {
                print("Error while fetching the user profile: \(error)")
                completion(nil, error)
                return
              }
              self.profile = profile
              completion(profile, nil)
            }
        }
    }
    
    func signIn(email:String, password:String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
            if let error = error {
              print("Error signing in: \(error)")
              completion(nil, error)
              return
            }
            
            guard let user = result?.user else { return }
            print("User \(user.uid) signed in.")

            self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
              if let error = error {
                print("Error while fetching the user profile: \(error)")
                completion(nil, error)
                return
              }

              self.profile = profile
              completion(profile, nil)
            }
        }
    }
    
    func signOut(){
        do {
          try Auth.auth().signOut()
          self.session = nil
          self.profile = nil
        }
        catch let signOutError as NSError {
          print("Error signing out: \(signOutError)")
        }
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
    
}

struct User {
    var uid: String
    var email: String?
    
    init(uid: String, email:String?){
        self.uid = uid
        self.email = email
    }
}
