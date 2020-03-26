//
//  YoutubePlayer.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import AVKit
import YoutubePlayer_in_WKWebView

struct YoutubePlayer : UIViewRepresentable {
    
    let videoID: String
    
    func makeUIView(context: UIViewRepresentableContext<YoutubePlayer>) -> WKYTPlayerView {
        return WKYTPlayerView()
    }
    
    func updateUIView(_ uiView: WKYTPlayerView, context: UIViewRepresentableContext<YoutubePlayer>) {
        uiView.load(withVideoId: videoID)
    }
}
