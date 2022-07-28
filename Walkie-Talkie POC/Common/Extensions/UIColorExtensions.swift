//
//  UIColorExtensions.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 28/07/2022.
//

import Foundation
import UIKit

extension UIColor {
    static let greenTY = UIColor(red: 78/255, green: 154/255, blue: 131/255, alpha: 1)
    static let redTY = UIColor(red: 222/255, green: 97/255, blue: 97/255, alpha: 1)
    static let darkGrayTY = UIColor(red: 108/255, green: 108/255, blue: 108/255, alpha: 1)
    static let lightGrayTY = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    static let lightSecondaryGrayTY = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
    
    static let yellowTY = UIColor(red: 240/255, green: 209/255, blue: 100/255, alpha: 1)
    static let blueTY = UIColor(red: 112/255, green: 174/255, blue: 231/255, alpha: 1)
    static let orangeTY = UIColor(red: 231/255, green: 162/255, blue: 112/255, alpha: 1)
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

}
