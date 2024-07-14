//
//  View+Extension.swift
//  WBHomework_first
//
//  Created by Kirill on 07.07.2024.
//

import SwiftUI

fileprivate struct ModifierCornerRadiusWithBorder: ViewModifier {
    var radius: CGFloat
    var isHidden: Bool
    var borderLineWidth: CGFloat = 1
    var borderColor: Color = .gray
    var antialiased: Bool = true
    
    func body(content: Content) -> some View {
        let borderLineWidth = isHidden ? 0 : self.borderLineWidth
        content
            .cornerRadius(radius, antialiased: self.antialiased)
            .overlay(
                RoundedRectangle(cornerRadius: self.radius)
                    .inset(by: borderLineWidth)
                    .strokeBorder(self.borderColor, lineWidth: borderLineWidth, antialiased: self.antialiased)
            )
    }
}

extension View {
    
    func cornerRadiusWithBorder(radius: CGFloat,
                                isHidden: Bool,
                                borderLineWidth: CGFloat = 1,
                                borderColor: Color = .red,
                                antialiased: Bool = true) -> some View {
        modifier(ModifierCornerRadiusWithBorder(radius: radius,
                                                isHidden: isHidden,
                                                borderLineWidth: borderLineWidth,
                                                borderColor: borderColor,
                                                antialiased: antialiased))
    }
    
}
