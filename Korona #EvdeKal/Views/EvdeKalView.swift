//
//  EvdeKalView.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 20.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import MessageUI

struct EvdeKalView: View {
    
    @ObservedObject var selectedCategory = CategorySelect()
    
    private let mailComposeDelegate = MailComposerDelegate()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20){
                    CategorySegment(selectedCategory: selectedCategory).frame(width:UIScreen.main.bounds.width, alignment: .trailing).padding(.top)
                    Group {
                        if selectedCategory.selected == 0 {
                            FilmList().padding(.horizontal)
                        }else if selectedCategory.selected == 1{
                            BookList().padding(.horizontal)
                        }else if selectedCategory.selected == 2{
                            MusicList().padding(.horizontal)
                        }else if selectedCategory.selected == 3{
                            GameList().padding(.horizontal)
                        }else if selectedCategory.selected == 4{
                            EventList().padding(.horizontal)
                        }else if selectedCategory.selected == 5{
                            OpportunitiesList().padding(.horizontal)
                        }else if selectedCategory.selected == 6{
                            LinkList().padding(.horizontal)
                        }else if selectedCategory.selected == 7{
                            CourseList().padding(.horizontal)
                        }else if selectedCategory.selected == 8{
                            SporList().padding(.horizontal)
                        }else{
                            EmptyView()
                        }
                    }
                }
            }
            .navigationBarTitle(Text("#EvdeKal"))
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentMailCompose()
                }, label: {
                    HStack(spacing: 10){
                        Text("Öneri Yap")
                        Image(systemName: "square.and.pencil")
                    }
                })
            )
        }
    }
}

// MARK: The mail part
extension EvdeKalView {
    private class MailComposerDelegate: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {

            controller.dismiss(animated: true)
        }
    }
    /// Present an mail compose view controller modally in UIKit environment
    private func presentMailCompose() {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        let vc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        let composeVC = MFMailComposeViewController()
        composeVC.setToRecipients(["info@labters.com"])
        composeVC.setSubject("Öneri Yapmak İstiyorum")
        composeVC.setMessageBody("<p>Kategori: (Örn: Film Tavsiyesi)</p><p>Önerdiğiniz İçerik: (Örn: V for Vendetta)</p>", isHTML: true)
        composeVC.mailComposeDelegate = mailComposeDelegate

        vc?.present(composeVC, animated: true)
    }
}

struct EvdeKalView_Previews: PreviewProvider {
    static var previews: some View {
        EvdeKalView()
    }
}
