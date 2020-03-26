//
//  StepbyStep.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI

struct StepbyStep: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            Text("#EvdeKal").font(.title).fontWeight(.black).foregroundColor(Color(UIColor.systemGreen))
            HStack(alignment: .center, spacing: 20){
                Image(systemName: "1.circle").font(.largeTitle).foregroundColor(Color(UIColor.systemGreen))
                Text("Ziyaretçi kabul etmeyin.").font(.headline)
            }
            Divider()
            HStack(alignment: .center, spacing: 20){
                Image(systemName: "2.circle").font(.largeTitle).foregroundColor(Color(UIColor.systemGreen))
                Text("Mümkünse ayrı bir odada kalın.").font(.headline)
            }
            Divider()
            HStack(alignment: .center, spacing: 20){
                Image(systemName: "3.circle").font(.largeTitle).foregroundColor(Color(UIColor.systemGreen))
                Text("Mümkünse ayrı tuvalet ve banyo kullanın.").font(.headline)
            }
            Divider()
            HStack(alignment: .center, spacing: 20){
                Image(systemName: "4.circle").font(.largeTitle).foregroundColor(Color(UIColor.systemGreen))
                Text("Sık sık el hijyeni sağlayın (Ellerinizi su ve normal sabunla yıkayın ve alkollü el antiseptiği ile ovalayın).").font(.headline)
            }
            Divider()
            HStack(alignment: .center, spacing: 20){
                Image(systemName: "5.circle").font(.largeTitle).foregroundColor(Color(UIColor.systemGreen))
                Text("Tabak, bardak, havlu vb. gibi eşyalarınızı ayırın, ortak kullanmayın.").font(.headline)
            }
        }
    }
}

struct StepbyStep_Previews: PreviewProvider {
    static var previews: some View {
        StepbyStep()
    }
}

