//
//  TextWithAttributedString.swift
//  Korona #EvdeKal
//
//  Created by Halil İbrahim YÜCE on 26.03.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class ViewWithLabel : UIView {
    private var label = UILabel()
    
    override init(frame: CGRect) {
            super.init(frame:frame)
            self.addSubview(label)
            label.numberOfLines = 0
            label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize{
        self.label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 32, height: 9999))
    }
    
    func setString(_ html:String) {
        DispatchQueue.main.async {
            self.label.attributedText = html.convertHtml()
            self.label.textColor = UIColor(named: "DarkColor")!
        }
    }
}

struct TextWithAttributedString: UIViewRepresentable {

    var html: String

    func makeUIView(context: Context) -> ViewWithLabel {
        let view = ViewWithLabel(frame: .zero)
        return view
    }

    func updateUIView(_ uiView: ViewWithLabel, context: Context) {
        DispatchQueue.main.async {
            uiView.setString(self.html)
        }
    }
}
