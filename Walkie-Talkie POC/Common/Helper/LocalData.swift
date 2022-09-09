//
//  LocalData.swift
//  BBB
//
//  Created by quannv on 1/2/17.
//  Copyright © 2017 quannv. All rights reserved.
//

import UIKit
import Foundation
import CoreFoundation
import KeychainSwift

enum LocalDataIdentifier: String {
    case firstRunApp = "first_run_app"
    case pushNotifyToken = "push_notify_token"
    case userLanguage = "userLanguage"
    case messageApp = "messageApp"
    case turnOnNotification = "turnOnNotification"
    
    case userEmail = "user_email"
    case userSession = "user_session"
}

class LocalData: NSObject {
    static let local = LocalData()
    var keychain = KeychainSwift()
    
    override init() {
        super.init()
        keychain = KeychainSwift()
    }
    func save(data: Any?, forIdentifier ID: LocalDataIdentifier) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(data, forKey: ID.rawValue)
        userDefault.synchronize()
    }
    
    func data(_ ID: LocalDataIdentifier) -> Any? {
        let userDefault = UserDefaults.standard
        let data = userDefault.object(forKey: ID.rawValue)
        return data
    }
    
}



// MARK: - Notify
extension LocalData {
    func saveNotification(isOn: Bool) {
        save(data: isOn, forIdentifier: .turnOnNotification)
    }
    
    func getNotificationState() -> Bool? {
        let isOn = data(.turnOnNotification) as? Bool
        return isOn
    }
}


// MARK: - Token
extension LocalData {
    func savePushNotifyToken(token: String) {
        save(data: token, forIdentifier: LocalDataIdentifier.pushNotifyToken)
    }
    
    func getPushNotifyToken() -> String? {
        let token = data(LocalDataIdentifier.pushNotifyToken) as? String
        return token
    }
    
}


// MARK: - Save and get user
extension LocalData {
    /// MARK: - User Language
    func saveUserLanguage(langCode: String) {
        self.save(data: langCode, forIdentifier: .userLanguage)
    }
    
    func getUserLanguage() -> String {
        return data(.userLanguage) as? String ?? ""
    }
    
    
    /// MARK: - Fake Register User
    func saveUserEmail(email: String) {
        self.save(data: email, forIdentifier: .userEmail)
    }
    
    func getUserEmail() -> String {
        return data(.userEmail) as? String ?? ""
    }
    
    func saveUserSession(session: String?) {
        self.save(data: session, forIdentifier: .userSession)
    }
    
    func getUserSession() -> String? {
        return data(.userSession) as? String
    }
    
}


// MARK: - Other
extension LocalData {
    func saveMessageApp(message: String) {
        save(data: message, forIdentifier: .messageApp)
    }
    
    func getMessageApp() -> String {
        guard let message = data(.messageApp) as? String else {
            return ""
        }
        return message
    }
    
    func saveFisrtRunApp(value: Bool) {
        save(data: value, forIdentifier: LocalDataIdentifier.firstRunApp)
    }
    
    func isFirtRunApp() -> Bool {
        return data(LocalDataIdentifier.firstRunApp) as? Bool ?? true
    }
}
