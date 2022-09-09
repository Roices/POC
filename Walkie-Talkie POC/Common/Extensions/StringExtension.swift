//
//  StringExtension.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 09/08/2022.

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment:"")
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    var intValue: Int {
        return (self as NSString).integerValue
    }
    var length: Int {
        return self.count
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    func isNumberFormat() -> Bool {
        let PHONE_REGEX = "\\d{10}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        if result == true {
            print("'\(self)' is a valid number.")
        } else {
            print("'\(self)' is an invalid number.")
        }
        return result
    }
    
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
}

extension String {
    
    // Returns true if the string has at least one character in common with matchCharacters.
    func containsCharactersIn(_ matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet) != nil
    }
    
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(_ matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
    // Returns true if the string has no characters in common with matchCharacters.
    func doesNotContainCharactersIn(_ matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet) == nil
    }
    
    // Returns true if the string represents a proper numeric value.
    // This method uses the device's current locale setting to determine
    // which decimal separator it will accept.
    func isNumeric() -> Bool
    {
        let scanner = Scanner(string: self)
        
        // A newly-created scanner has no locale by default.
        // We'll set our scanner's locale to the user's locale
        // so that it recognizes the decimal separator that
        // the user expects (for example, in North America,
        // "." is the decimal separator, while in many parts
        // of Europe, "," is used).
        scanner.locale = Locale.current
        
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
    
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    
    func convertStringToDictionary() -> [String: Any]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    func convertStringToArray() -> [[String: Any]]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    func stringByRemovingEmoji() -> String {
        return self.unicodeScalars.filter({!$0.isEmoji}).reduce("") { (result, unicode) -> String in
            return result + String(unicode)
        }
        //        return String(self.characters.filter{!$0.isEmoji()})
    }
    
}

extension UnicodeScalar {
    
    var isEmoji: Bool {
        
        switch value {
        case 0x3030, 0x00AE, 0x00A9, // Special Characters
        0x1D000 ... 0x1F77F, // Emoticons
        0x2100 ... 0x27BF, // Misc symbols and Dingbats
        0xFE00 ... 0xFE0F, // Variation Selectors
        0x1F900 ... 0x1F9FF: // Supplemental Symbols and Pictographs
            return true
            
        default: return false
        }
    }
    
    var isZeroWidthJoiner: Bool {
        
        return value == 8205
    }
}

extension String {
    
    var glyphCount: Int {
        
        let richText = NSAttributedString(string: self)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }
    
    var isSingleEmoji: Bool {
        
        return glyphCount == 1 && containsEmoji
    }
    
    var containsEmoji: Bool {
        
        return !unicodeScalars.filter { $0.isEmoji }.isEmpty
    }
    
    var containsOnlyEmoji: Bool {
        
        return !isEmpty && unicodeScalars.first(where: { !$0.isEmoji && !$0.isZeroWidthJoiner }) == nil
    }
    
    // The next tricks are mostly to demonstrate how tricky it can be to determine emoji's
    // If anyone has suggestions how to improve this, please let me know
    var emojiString: String {
        
        return emojiScalars.map { String($0) }.reduce("", +)
    }
    
    var emojis: [String] {
        
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?
        
        for scalar in emojiScalars {
            
            if let prev = previousScalar, !prev.isZeroWidthJoiner && !scalar.isZeroWidthJoiner {
                
                scalars.append(currentScalarSet)
                currentScalarSet = []
            }
            currentScalarSet.append(scalar)
            
            previousScalar = scalar
        }
        
        scalars.append(currentScalarSet)
        
        return scalars.map { $0.map{ String($0) } .reduce("", +) }
    }
    
    fileprivate var emojiScalars: [UnicodeScalar] {
        
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            
            if let previous = previous, previous.isZeroWidthJoiner && cur.isEmoji {
                chars.append(previous)
                chars.append(cur)
                
            } else if cur.isEmoji {
                chars.append(cur)
            }
            
            previous = cur
        }
        
        return chars
    }
}


extension NSAttributedString {
    
    class func createAtributedString(text: String, font: UIFont, color: UIColor = UIColor.black) -> NSAttributedString {
        let attributed = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font: font])
        
        return attributed
    }
    
    class func compoundAttritbutedString(listAttributeds: [NSAttributedString]) -> NSAttributedString {
        let attributedCompound = NSMutableAttributedString()
        for attributed in listAttributeds {
            attributedCompound.append(attributed)
        }
        return attributedCompound
    }
}


extension String {
    func removeSignVietnamese() -> String {
        var standard = ""
        for c in self {
            let str = String(c)
            if "áàạảãâấầậẩẫăắằặẳẵ".contains(str) {
                standard.append("a")
            } else if "ÁÀẠẢÃÂẤẦẬẨẪĂẮẰẶẲẴ".contains(str) {
                standard.append("A")
            } else if "éèẹẻẽêếềệểễ".contains(str) {
                standard.append("e")
            } else if "ÉÈẸẺẼÊẾỀỆỂỄ".contains(str) {
                standard.append("E")
            } else if "óòọỏõôốồộổỗơớờợởỡ".contains(str) {
                standard.append("o")
            } else if "ÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ".contains(str) {
                standard.append("O")
            } else if "úùụủũưứừựửữ".contains(str) {
                standard.append("u")
            } else if "ÚÙỤỦŨƯỨỪỰỬỮ".contains(str) {
                standard.append("U")
            } else if "íìịỉĩ".contains(str) {
                standard.append("i")
            } else if "ÍÌỊỈĨ".contains(str) {
                standard.append("I")
            } else if "đ".contains(str) {
                standard.append("d")
            } else if "Đ".contains(str) {
                standard.append("D")
            } else if "ýỳỵỷỹ".contains(str) {
                standard.append("y")
            } else if "ÝỲỴỶỸ".contains(str) {
                standard.append("Y")
            } else {
                standard.append(str)
            }
        }
        
        if let data = standard.data(using: String.Encoding.ascii, allowLossyConversion: true) {
            if let textResult = String(data: data, encoding: String.Encoding.utf8) {
                return textResult
            } else {
                return standard
            }
        } else {
            return standard
        }
    }
    
    
    var stringByRemovingWhitespaces: String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.joined(separator: "")
    }
    

    func toJSONArray() -> [String] {
        let data = self.data(using: .utf8)!
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String] {
            return json
        } else {
            print("bad json - do some recovery")
        }
        
        return []
    }
    
    func toJSONObject() -> [String: Any] {
        let data = self.data(using: .utf8)!
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any] {
            return json
        } else {
            print("bad json - do some recovery")
        }
        
        return [:]
    }
    
    static func jsonString(dict: [String: Any]) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {
                return "{}"
            }
            
            return jsonString
            // here "decoded" is of type `Any`, decoded from JSON data
        } catch {
            return "{}"
        }
    }
    
    static func stringWithNumber(number: Double, withCurrencySymbol currencySymbol: String, withNumberOfFractionDigits numberFractionDigit: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "vi_VN")
        numberFormatter.maximumFractionDigits = numberFractionDigit
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.currencySymbol = currencySymbol
        numberFormatter.usesGroupingSeparator = true
        
        return numberFormatter.string(from: NSNumber(value: number))
    }
    
//    static func currencyStringOfNumber(number: Double) -> String {
//        return currencyStringOfNumber(number: number, withCurrency: .VND)
//    }
//    
//    static func fomatterNumberToDisplay(number: Int64) -> String {
//        if number >= 1000000 {
//            return String(format: "%ldM", Int64(Double(number)/1000000))
//        }
//        
//        if number >= 1000 {
//            return String(format: "%ldK", Int64(Double(number)/1000))
//        }
//        return String(format: "%ld", Int64(Double(number)))
//    }
    
//    static func currentWithSymbol(symbol: String?) -> CurrencyUnit {
//        if symbol == "VND" {
//            return CurrencyUnit.VND
//        } else if symbol == "USD" {
//            return CurrencyUnit.DOLA
//        } else {
//            return CurrencyUnit.VND
//        }
//    }
    
//    static func currencyStringOfNumber(number: Double, withCurrency currency: CurrencyUnit?) -> String {
//        if currency != nil {
//            if let string = stringWithNumber(number: number, withCurrencySymbol: "", withNumberOfFractionDigits: 0) {
//                return string + " " + "đ"
//            } else {
//                return ""
//            }
//        } else {
//            if let string = stringWithNumber(number: number, withCurrencySymbol: "", withNumberOfFractionDigits: 0) {
//                return string
//            } else {
//                return ""
//            }
//        }
//    }
    
    static func percentStringOfNumber(number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        if let string = numberFormatter.string(from: NSNumber(value: number)) {
            return string
        } else {
            return ""
        }
    }
    
    static func numberWithString(string: String, withCurrencySymbol currencySymbol: String, withNumberOfFractionDigits numberFractionDigit: Int) -> NSNumber? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "vi_VN")
        numberFormatter.maximumFractionDigits = numberFractionDigit
        numberFormatter.minimumFractionDigits = numberFractionDigit
        numberFormatter.currencySymbol = currencySymbol
        numberFormatter.usesGroupingSeparator = true
        
        return numberFormatter.number(from: string)
    }
    
    static func stringWithNumber(number: Double, withNumberOfFractionDigits numberFractionDigit: Int) -> String? {
        let num = number
        let numerDigit = numberFractionDigit
        let unit = ""
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "vi_VN")
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = numerDigit
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.usesGroupingSeparator = true
        
        return (numberFormatter.string(from: NSNumber(value: num)) ?? "") + unit
    }
    
    static func stringWithNumber(number: Double) -> String? {
        let num = number
        let unit = ""
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "vi_VN")
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.usesGroupingSeparator = false
        
        return (numberFormatter.string(from: NSNumber(value: num)) ?? "") + unit
    }
    
    static func stringWithNumber(number: Double, withNumberOfFractionDigits numberFractionDigit: Int, usesGroupingSeparator: Bool) -> String? {
        let num = number
        let numerDigit = numberFractionDigit
        let unit = ""
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "vi_VN")
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = numerDigit
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.usesGroupingSeparator = usesGroupingSeparator
        
        return (numberFormatter.string(from: NSNumber(value: num)) ?? "") + unit
    }
    
    static func formattedStringWithPhoneNumber(phoneNumber: String?) -> String? {
        if let phoneNumber = phoneNumber {
            if phoneNumber.count > 1 {
                let twoFirstCharacterString = (phoneNumber as NSString).substring(to: 2)
                if Int(twoFirstCharacterString) == 84 {
                    return (phoneNumber as NSString).replacingCharacters(in: NSMakeRange(0, 2), with: "0")
                } else {
                    return phoneNumber
                }
            } else {
                return phoneNumber
            }
        } else {
            return nil
        }
    }

    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func formatPhoneNumberOfVietnamese() -> String {
        let prefixNumberPhone = "+84"
        //phone.characters
        if let _ = self.range(of: prefixNumberPhone) {
            return self
        } else if let characterFirst = self.first,  (String(characterFirst) == "0" || String(characterFirst) == "+") {
            let phoneResult = trimFirstLetterAndAddPrefixNumberPhone(prefix: prefixNumberPhone)
            return phoneResult
        }
        return prefixNumberPhone + self
    }
    
    func trimFirstLetterAndAddPrefixNumberPhone(prefix: String) -> String {
        
        let cleanedString = String(self.dropFirst())
        return prefix + cleanedString
    }
    
    func trim() -> String {
      return trimmingCharacters(in: CharacterSet.whitespaces)
    }

    func range(from nsRange: NSRange) -> Range<String.Index>? {
      guard
        let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
        let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
        let from = String.Index(from16, within: self),
        let to = String.Index(to16, within: self)
        else { return nil }
      return from ..< to
    }

}
