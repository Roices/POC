//
//  Util.swift
//

import Foundation
import UIKit

func roundCurrencyVND(amount: Double) -> Double {
    return Double(Int(amount) / 1000 * 1000)
}

//func chooseTimeRange(selectedPreviousId: String?,
//                     sourcePresent: UIViewController,
//                     sourceView: UIView,
//                     sourceRect: CGRect,
//                     didChooseItem: @escaping ((_ item: DropDownItem)->())) {
//    let items = getListOptions().map({$0.toDropdownItem()})
//    if let selectedPreviousId = selectedPreviousId, !selectedPreviousId.isEmpty {
//        for item in items {
//            item.isSelected = selectedPreviousId == item.id
//        }
//    }
//
//    let listViewVC = PopoverListViewController(nibName: "PopoverListViewController", bundle: nil)
//    listViewVC.listItem = items
//    listViewVC.didSelectedItem = { (item) in
//        switch item.id {
//        case "\(ID_CUSTOM_TIME)":
//             let chooseDateRange = ChooseDateRangeView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300), title: "Chọn khung thời gian")
//             chooseDateRange.didSelectedRange = { (startDat, endDate) in
//                let dropdownItem = item
//                item.dateRange = (startDat, endDate)
//                didChooseItem(dropdownItem)
//             }
//             chooseDateRange.show()
//
//        default:
//            didChooseItem(item)
//
//        }
//    }
//
//    listViewVC.preferredContentSize = CGSize(width: 300, height: CGFloat(items.count * 50))
//    listViewVC.modalPresentationStyle = .popover
//    let popover = listViewVC.popoverPresentationController
//    popover?.permittedArrowDirections = .any
//    popover?.delegate = sourcePresent as? UIPopoverPresentationControllerDelegate
//    popover?.sourceView = sourceView
//    popover?.sourceRect = sourceRect
//    sourcePresent.present(listViewVC, animated: true, completion: nil)
//}

//func chooseOption(selectedPreviousId: String?,
//                  listDropDown: [DropDownItem],
//                  sourcePresent: UIViewController,
//                  sourceView: UIView,
//                  sourceRect: CGRect,
//                  width: CGFloat = 300,
//                  permittedArrowDirections: UIPopoverArrowDirection = .any,
//                  didChooseItem: @escaping ((_ item: DropDownItem)->())) {
//    let items = listDropDown
//    for item in items {
//        item.isSelected = selectedPreviousId == item.id
//    }
//
//
//    let listViewVC = PopoverListViewController(nibName: "PopoverListViewController", bundle: nil)
//    listViewVC.listItem = items
//    listViewVC.didSelectedItem = { (item) in
//        didChooseItem(item)
//    }
//
//    listViewVC.preferredContentSize = CGSize(width: width, height: CGFloat(items.count * 50))
//    listViewVC.modalPresentationStyle = .popover
//    let popover = listViewVC.popoverPresentationController
//    popover?.permittedArrowDirections = permittedArrowDirections
//    popover?.delegate = sourcePresent as? UIPopoverPresentationControllerDelegate
//    popover?.sourceView = sourceView
//    popover?.sourceRect = sourceRect
//    sourcePresent.present(listViewVC, animated: true, completion: nil)
//}
//
//
//
//func generateDecimalId() -> NSDecimalNumber {
//    return NSDecimalNumber(value: Date().timeIntervalSince1970)
//}
//
//
//func drawLineFromPoint(_ start: CGPoint, toPoint end: CGPoint, ofColor lineColor: UIColor, inView view: UIView) -> CALayer {
//    let line = CALayer()
//    line.backgroundColor = lineColor.cgColor
//    if start.y == end.y { // horizoltal line
//        line.frame = CGRect(x: start.x, y: start.y, width: end.x - start.x, height: AppSetting.separatorHeight)
//    } else { // vertical line
//        line.frame = CGRect(x: start.x, y: start.y, width: AppSetting.separatorHeight, height: end.y - start.y)
//    }
//
//    view.layer.addSublayer(line)
//    return line
//}
//
//func removeSignVietnamese(_ text: String) -> String {
//    return text.removeSignVietnamese()
//}
//
//func encodePhoneNumber(phone: String) -> String {
//    var newPhone = ""
//    for (idx, c) in phone.enumerated() {
//        if idx < phone.length - 3 {
//            newPhone = newPhone.appending("*")
//        } else {
//            newPhone = newPhone.appending(String(c))
//        }
//    }
//    return newPhone
//}
//
//
//func encodeEmailAddress(email: String) -> String {
//    let component = email.components(separatedBy: "@")
//    guard let last = component.last else {
//        return email
//    }
//
//
//    return "*****@" + last
//}
//
//func toDouble(_ string: String) -> Double {
//    let components = string.components(separatedBy: ".")
//    var index = 100
//    var total: Double = 0
//    for component in components {
//        let doubleValue = Double(component) ?? 0
//        total = total + (Double(index) * doubleValue)
//        index = index / 10
//    }
//
//    return total
//}
//
//func getAppVersion() -> Double {
//    let dicInfo = Bundle.main.infoDictionary
//    if let appversion = dicInfo?["CFBundleShortVersionString"] as? String {
//        let version = toDouble(appversion)
//        return version
//
//    } else {
//        return 1.0
//    }
//}
//
//func showErrorDB() {
//    let message = NSLocalizedString("Database has problem", comment: "")
//    showMessage(message)
//}


func messageForError(_ error: NSError) -> String {
    let errorCode = error.code
    switch errorCode {
    case NSURLErrorBadURL:
        return NSLocalizedString("Lỗi kết nối. Xin vui lòng kiểm tra và thử lại", comment: "")
    case NSURLErrorTimedOut:
        return NSLocalizedString("Lỗi kết nối. Xin vui lòng kiểm tra và thử lại", comment: "")
    case NSURLErrorCannotFindHost:
        return NSLocalizedString("Lỗi kết nối. Xin vui lòng kiểm tra và thử lại", comment: "")
    case NSURLErrorCannotConnectToHost:
        return NSLocalizedString("Lỗi kết nối. Xin vui lòng kiểm tra và thử lại", comment: "")
    case NSURLErrorNetworkConnectionLost:
        return NSLocalizedString("Lỗi kết nối. Xin vui lòng kiểm tra và thử lại", comment: "")
    case NSURLErrorNotConnectedToInternet:
        return NSLocalizedString("Lỗi kết nối. Xin vui lòng kiểm tra và thử lại", comment: "")
    default:
        return error.localizedDescription
    }
}

func getHourAndMinuteFromDate(_ date: Date) -> (hour: Int, minute: Int) {
    let calendar = Calendar.current
    let hour = (calendar as NSCalendar).component(.hour, from: date)
    let minute = (calendar as NSCalendar).component(.minute, from: date)
    return (hour, minute)
}

func addTimeInfo(_ hourKey: String, minuteKey: String, withTime time: Date, forInforData dataInfo: NSMutableDictionary) {

    let hourAndMinute = getHourAndMinuteFromDate(time)
    dataInfo.setObject(hourAndMinute.hour, forKey: hourKey as NSCopying)
    dataInfo.setObject(hourAndMinute.minute, forKey: minuteKey as NSCopying)
}


func isSimulator() -> Bool {
    #if targetEnvironment(simulator)
        return true
    #else
        return false
    #endif
}

func IS_RETINA() -> Bool {
    return UIScreen.main.scale >= 2.0
}

// MARK: - Get ID
func generateID() -> String {
    let timeStam = Int64(Date().timeIntervalSince1970 * 1000)
    let id = "\(timeStam)"
    return id
}

// MARK: - Get Device infor
func getPlatformString() -> String {
    var size: Int = 0 // as Ben Stahl noticed in his answer
    sysctlbyname("hw.machine", nil, &size, nil, 0)
    var machine = [CChar](repeating: 0, count: Int(size))
    sysctlbyname("hw.machine", &machine, &size, nil, 0)
    if let platfom = String(validatingUTF8: machine) {
        return platfom
    } else {
        return ""
    }
}

func getDeviceType() -> String {
    return "IOS"
}

func getAppVersionString() -> String {
    let dicInfo = Bundle.main.infoDictionary
    if let appversion = dicInfo?["CFBundleShortVersionString"] as? String {
        return appversion
    } else {
        return ""
    }
}


// MARK: - date
let dateFormatter: DateFormatter = DateFormatter()
var token: Int = 0

func getDateFormatter() -> DateFormatter {
    return dateFormatter
}

func dateFormatterToParseString() -> DateFormatter {
    let dateFormatter = getDateFormatter()
//    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    return dateFormatter
}

func dateFormatterToGetDisplay() -> DateFormatter {
    let dateFormatter = getDateFormatter()
//    dateFormatter.locale = AppLocale.sharedInstance.locale as Locale!
    return dateFormatter
}

func stringFromDate(_ date: Date, withDateFormat format: String) -> String {
    let dateFormatter = dateFormatterToGetDisplay()
    if dateFormatter.dateFormat != format {
        dateFormatter.dateFormat = format
    }
    let stringDate = dateFormatter.string(from: date)
    return stringDate
}

func dateFromString(_ stringDate: String, withDateFormat format: String) -> Date? {
    let dateFormatter = dateFormatterToParseString()
    if dateFormatter.dateFormat != format {
        dateFormatter.dateFormat = format
    }
    let date = dateFormatter.date(from: stringDate)
    return date
}

func truncateTimeOfDate(_ date: Date) -> Date { // chi lay Year, Month
    let calendar = Calendar.current
    let dateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.month, NSCalendar.Unit.year], from: date)
    let returnDate = calendar.date(from: dateComponents)
    return returnDate ?? Date()
}

// MARK: - String util
func isEmail(_ string: String?) -> Bool {
    if let string = string {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: string, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, string.length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    } else {
        return false
    }
}

func isPhoneNumber(_ string: String?) -> Bool {
    if let string = string {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
        let match = dataDetector?.matches(in: string, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, string.length))
        if match?.count == 1 {
            return true
        } else {
            return false
        }
    } else {
        return false
    }
}

func isValideLink(_ string: String?) -> Bool {
    if let string = string, string.length > 0 {
        if let _ = URL(string: string) {
            return true
        } else {
            return false
        }
    } else {
        return false
    }
}



//func getTimeIntervalDisplayWithCurrentTime(_ time: Date) -> (value: Int, unit: TimeUnit) {
//
//    let currentTime = Date()
//    let timeInterval = currentTime.timeIntervalSince(time)
//    let minute = Int(timeInterval) / 60
//    let hour = Int(timeInterval) / (60 * 60)
//    let day = Int(timeInterval) / (60 * 60 * 24)
//    let month = Int(timeInterval) / (60 * 60 * 24 * 30)
//
//    var timeUnit = TimeUnit.Second
//    var timeValue: Int = 0
//
//    if minute < 60 {
//        if minute < 1 {
//            timeValue = Int(timeInterval)
//            timeUnit = TimeUnit.Second
//        } else {
//            timeValue = minute
//            timeUnit = TimeUnit.Minute
//        }
//    } else if (hour <= 24) {
//        timeValue = hour
//        timeUnit = TimeUnit.Hour
//    } else if day <= 30 {
//        timeValue = day
//        timeUnit = TimeUnit.Day
//    } else {
//        timeValue = month
//        timeUnit = TimeUnit.Month
//    }
//    return (timeValue, timeUnit)
//}


func convertImageToData(_ image: UIImage) -> Data {
    let data = image.pngData();
    return data!
}

func encodeToBase64String(_ image: UIImage) -> Data {
    let data = image.pngData();
    return data!
}

// MARK: - Printer util string
func createStringWithName(_ name: String, amount: String, isFontSmall: Bool = false) -> String {

    var totalCharacter = 32
    if isFontSmall {
        totalCharacter = 42
    }

    var namePrint = ""
    let countNameCharacter = totalCharacter - 15
    if name.count > countNameCharacter {
        namePrint = (name as NSString).substring(to: countNameCharacter - 3)
        namePrint = namePrint + "..."
    } else {
        namePrint = name
        for _ in 0 ..< countNameCharacter - name.count {
            namePrint = namePrint + " "
        }
    }

    // 15
    var amountString = " "
    if amount.count > 14 {
        amountString = (amount as NSString).substring(to: 13)
    } else {
        for _ in 0 ..< 14 - amount.count {
            amountString = amountString + " "
        }
        amountString = amountString + amount
    }

    return namePrint + amountString
}

func createStringFontSmallWithName(_ name: String, count: String, amount: String) -> String {

    // 24
    var namePrint = ""
    if name.count > 24 {
        namePrint = (name as NSString).substring(to: 21)
        namePrint = namePrint + "..."
    } else {
        namePrint = name
        for _ in 0 ..< 24 - name.count {
            namePrint = namePrint + " "
        }
    }

    // 5
    var countString = " "
    if count.count > 5 {
        countString = (count as NSString).substring(to: 3)
    } else {
        for _ in 0 ..< 5 - count.count {
            countString = countString + " "
        }
        countString = countString + count
    }

    // 12
    var amountString = " "
    if amount.count > 12 {
        amountString = " " + (amount as NSString).substring(to: 11)
    } else {
        for _ in 0 ..< 11 - amount.count {
            amountString = amountString + " "
        }
        amountString = amountString + amount
    }

    return namePrint + countString + amountString
}

func formattedStringWithPhoneNumber(_ phoneNumber: String?) -> String? {
    if let phoneNumber = phoneNumber {
        if phoneNumber.length > 1 {
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

struct FormatTimeInterval {
    var minute: Int64 = 0
    var hour: Int64 = 0
    var day: Int64 = 0
    
    init(timeInterval: Double) {
        
        if timeInterval > 24 * 3600 {
            self.day = (Int64(timeInterval) / Int64((24 * 3600)))
        }
        
        var timeRemain = Int64(timeInterval) - day * 24 * 3600
        self.hour = timeRemain / 3600
        
        timeRemain = timeRemain - hour * 3600
        self.minute = timeRemain / 60
    }
    
    func getDisplay() -> String {
        if day > 0 {
            return "\(day) " + NSLocalizedString("ngày", comment: "") + " \(hour)" + NSLocalizedString("h", comment: "") + "\(minute)p"
        }
        
        return "\(hour)" + NSLocalizedString("h", comment: "") + "\(minute)p"
    }
}
