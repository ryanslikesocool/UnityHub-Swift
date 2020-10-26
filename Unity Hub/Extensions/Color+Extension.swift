//
//  Colors.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 10/1/20.
//

import Foundation
import SwiftUI

extension Color {
    static var textColor: Color { return Color("textColor") }
    static var systemGray: Color { return Color("systemGray") }
    static var systemGray2: Color { return Color("systemGray2") }
    static var systemGray3: Color { return Color("systemGray3") }
    static var systemGray4: Color { return Color("systemGray4") }
    static var systemGray5: Color { return Color("systemGray5") }
    static var systemGray6: Color { return Color("systemGray6") }
    
    func multiply(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> Color {
        if let components = cgColor?.components {
            return Color(CGColor(red: components[0] * r, green: components[1] * g, blue: components[2] * b, alpha: components[3] * a))
        }
        return self
    }
    
    func multiply(v: CGFloat, a: CGFloat = 1) -> Color {
        return multiply(r: v, g: v, b: v, a: a)
    }
}
