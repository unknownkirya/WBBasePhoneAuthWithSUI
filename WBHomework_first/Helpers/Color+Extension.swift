//
//  Color+Extension.swift
//  WBHomework_first
//
//  Created by Kirill on 03.07.2024.
//

import SwiftUI

extension Color {
    
    static let customDarkPurple = Color(hex: "1D0628")
    static let customBluePurple = Color(hex: "1D0628")
    static let customBasePurple = Color(hex: "8400FF")
    static let customPressedPurple = Color(hex: "8400FF")
    
    static let customPhoneTextFieldPurple = Color(uiColor: #colorLiteral(red: 0.1965607703, green: 0.1429897845, blue: 0.2957178652, alpha: 1))
    
}

// MARK: - Custom Color hex init

extension Color {
    
    init(hex: String) {
            let scanner = Scanner(string: hex)
            var rgbValue: UInt64 = 0
            scanner.scanHexInt64(&rgbValue)
            
            let r = (rgbValue & 0xff0000) >> 16
            let g = (rgbValue & 0xff00) >> 8
            let b = rgbValue & 0xff
            
            self.init(
                red: CGFloat(r) / 0xff,
                green: CGFloat(g) / 0xff,
                blue: CGFloat(b) / 0xff
            )
        }
    
}
