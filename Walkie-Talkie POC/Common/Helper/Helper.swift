//
//  Helper.swift
//  QuickOrder
//
//  Created by MAC MINI  on 8/4/17.
//  Copyright © 2017 MAC MINI . All rights reserved.
//

import UIKit
import CoreData
import AVFoundation


class Helper: NSObject {
    static let helper = Helper()
    
    var localData = LocalData.local
    var local: Locale = Locale.current
    var audioPlayer: AVAudioPlayer?
    
    var user: User? {
        didSet {
            guard let username = user?.email else { return }
            LocalData.local.saveUserEmail(email: username)
            guard let session = user?.session?.value else { return }
            localData.saveUserSession(session: session)
        }
    }
    var isLogged: Bool {
        get {
            guard let token = LocalData.local.getUserSession(), !token.isEmpty else {
                return false
            }
            return true
        }
    }

    
    
    public func initHelper() {
    }
    
    public func clearHelper() {
        LocalData.local.saveUserSession(session: nil)
        user = nil
        NotificationCenter.default.removeObserver(self)
    }
}



// MARK: - Logout
extension Helper {
    public func logout() {
        clearHelper()
       // AppDelegate.shareDelegate.showSplashView()
    }
}
