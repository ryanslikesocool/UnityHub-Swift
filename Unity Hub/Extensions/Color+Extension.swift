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
	
	var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
		typealias NativeColor = NSColor

		var r: CGFloat = 0
		var g: CGFloat = 0
		var b: CGFloat = 0
		var o: CGFloat = 0
		
		NativeColor(self).usingColorSpace(.sRGB)?.getRed(&r, green: &g, blue: &b, alpha: &o)
		
		return (r, g, b, o)
	}

	static func lerp(_ from: Color, _ to: Color, _ rel: Float) -> Color {
		let fromComponents = from.components
		let toComponents = to.components
		
		let time = CGFloat(rel)
		
		let r = CGFloat.lerp(fromComponents.red, toComponents.red, time)
		let g = CGFloat.lerp(fromComponents.green, toComponents.green, time)
		let b = CGFloat.lerp(fromComponents.blue, toComponents.blue, time)
		let o = CGFloat.lerp(fromComponents.opacity, toComponents.opacity, time)
		
		let red = Double(r)
		let green = Double(g)
		let blue = Double(b)
		let opacity = Double(o)
		
		return Color(red: red, green: green, blue: blue, opacity: opacity)
	}
}
