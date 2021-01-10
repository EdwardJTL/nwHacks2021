//
//  Color+Extension.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-10.
//

import SwiftUI
import UIKit

extension Color {

    static var label: Color {
        return Color(UIColor.label)
    }

    static var secondaryLabel: Color {
        return Color(UIColor.secondaryLabel)
    }

    static var tertiaryLabel: Color {
        return Color(UIColor.tertiaryLabel)
    }

    static var quaternaryLabel: Color {
        return Color(UIColor.quaternaryLabel)
    }

    static var systemFill: Color {
        return Color(UIColor.systemFill)
    }

    static var secondarySystemFill: Color {
        return Color(UIColor.secondarySystemFill)
    }

    static var tertiarySystemFill: Color {
        return Color(UIColor.tertiarySystemFill)
    }

    static var quaternarySystemFill: Color {
        return Color(UIColor.quaternarySystemFill)
    }

    static var systemBackground: Color {
           return Color(UIColor.systemBackground)
    }

    static var secondarySystemBackground: Color {
        return Color(UIColor.secondarySystemBackground)
    }

    static var tertiarySystemBackground: Color {
        return Color(UIColor.tertiarySystemBackground)
    }

    static var systemGroupedBackground: Color {
        return Color(UIColor.systemGroupedBackground)
    }

    static var secondarySystemGroupedBackground: Color {
        return Color(UIColor.secondarySystemGroupedBackground)
    }

    static var tertiarySystemGroupedBackground: Color {
        return Color(UIColor.tertiarySystemGroupedBackground)
    }

    static var systemRed: Color {
        return Color(UIColor.systemRed)
    }

    static var systemBlue: Color {
        return Color(UIColor.systemBlue)
    }

    static var systemPink: Color {
        return Color(UIColor.systemPink)
    }

    static var systemTeal: Color {
        return Color(UIColor.systemTeal)
    }

    static var systemGreen: Color {
        return Color(UIColor.systemGreen)
    }

    static var systemIndigo: Color {
        return Color(UIColor.systemIndigo)
    }

    static var systemOrange: Color {
        return Color(UIColor.systemOrange)
    }

    static var systemPurple: Color {
        return Color(UIColor.systemPurple)
    }

    static var systemYellow: Color {
        return Color(UIColor.systemYellow)
    }

    static var systemGray: Color {
        return Color(UIColor.systemGray)
    }

    static var systemGray2: Color {
        return Color(UIColor.systemGray2)
    }

    static var systemGray3: Color {
        return Color(UIColor.systemGray3)
    }

    static var systemGray4: Color {
        return Color(UIColor.systemGray4)
    }

    static var systemGray5: Color {
        return Color(UIColor.systemGray5)
    }

    static var systemGray6: Color {
        return Color(UIColor.systemGray6)
    }

    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
#if canImport(UIKit)
        typealias NativeColor = UIColor
#elseif canImport(AppKit)
        typealias NativeColor = NSColor
#endif

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard NativeColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return (0, 0, 0, 0)
        }

        return (red, green, blue, alpha)
    }

    var inverted: Color {
        let red = self.components.red
        let green = self.components.green
        let blue = self.components.blue
        return Color(UIColor(displayP3Red: 1 - red, green: 1 - green, blue: 1 - blue, alpha: 1.0))
    }
}
