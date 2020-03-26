//
//  ContentView.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 20.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ForumView()
                .tabItem {
                    Image(systemName: "list.bullet.below.rectangle")
                    Text("Forum")
                }.tag(0)
            EvdeKalView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("#EvdeKal")
                }.tag(1)
            HealthView()
                .tabItem {
                    Image(systemName: "hand.raised.slash.fill")
                    Text("Sağlık")
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
