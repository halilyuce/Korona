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
            Text("Evde Kalarak").font(.title).fontWeight(.black).foregroundColor(Color(UIColor.systemGreen))
            HStack(alignment: .center, spacing: 20){
                Image(systemName: "1.circle").font(.largeTitle).foregroundColor(Color(UIColor.systemGreen))
                Text("Kendini ve sevdiklerini korursun").font(.headline)
            }
            Divider()
            HStack(alignment: .center, spacing: 20){
                Image(systemName: "2.circle").font(.largeTitle).foregroundColor(Color(UIColor.systemGreen))
                Text("Hastalığın yayılmasını önlersin").font(.headline)
            }
            Divider()
            HStack(alignment: .center, spacing: 20){
                Image(systemName: "3.circle").font(.largeTitle).foregroundColor(Color(UIColor.systemGreen))
                Text("Ailene ve sevdiklerine daha çok vakit ayırma fırsatını değerlendirebilirsin").font(.headline)
            }
            Divider()
            HStack(alignment: .center, spacing: 20){
                Image(systemName: "4.circle").font(.largeTitle).foregroundColor(Color(UIColor.systemGreen))
                Text("Uygulamamızdaki aktiviteler ile eğlenceli ve verimli vakit geçirebilirsin").font(.headline)
            }
            Divider()
            HStack(alignment: .center, spacing: 20){
                Image(systemName: "5.circle").font(.largeTitle).foregroundColor(Color(UIColor.systemGreen))
                Text("Sunduğumuz ücretsiz kurslar ile kişisel gelişiminize katkıda bulunabilirsiniz").font(.headline)
            }
        }
    }
}

struct StepbyStep_Previews: PreviewProvider {
    static var previews: some View {
        StepbyStep()
    }
}

