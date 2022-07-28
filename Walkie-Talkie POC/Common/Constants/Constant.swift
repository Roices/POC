//
//  Constant.swift
//  Walkie-Talkie POC
//
//  Created by Tuan on 22/07/2022.
//

import Foundation
import UIKit

enum Image {
    static let person = UIImage(systemName: "person.fill")!
    static let password = UIImage(systemName: "lock.fill")!
    static let calendar = UIImage(systemName: "calendar")!
    static let people = UIImage(systemName: "person.2.fill")!
    static let sideMenu = UIImage(named: "ic_sideMenu")!
}

enum Bound {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}
