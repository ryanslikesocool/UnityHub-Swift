import Foundation
import SwiftUI

extension Color {
	static let textColor: Color = Color(nsColor: .textColor)
    static let systemGray: Color = Color("systemGray")
    static let systemGray2: Color = Color("systemGray2")
    static let systemGray3: Color = Color("systemGray3")
    static let systemGray4: Color = Color("systemGray4")
    static let systemGray5: Color = Color("systemGray5")
    static let systemGray6: Color = Color("systemGray6")

    func multiply(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> Color {
        if let components = cgColor?.components {
            return Color(CGColor(red: components[0] * r, green: components[1] * g, blue: components[2] * b, alpha: components[3] * a))
        }
        return self
    }

    func multiply(v: CGFloat, a: CGFloat = 1) -> Color {
        multiply(r: v, g: v, b: v, a: a)
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
