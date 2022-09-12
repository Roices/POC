//
//  User.swift
//  VietinWorkspace
//
//  Created by localvn on 16/08/2022.
//  Copyright © 2022 QuanHong. All rights reserved.
//

import Foundation

class User: Codable {
    var email: String?
    var emailAddress: String?
    var displayName: String?
    var name: String?
    var session: UserSession?
    var errorMessages: [String]?
 //   var role: UserRole?
    var avatarUrls: AvatarUrls?
    var expand: String?
    
    private enum CodingKeys : String, CodingKey {
        case email = "email"
        case emailAddress = "emailAddress"
        case displayName = "displayName"
        case name = "name"
        case session = "session"
        case errorMessages = "errorMessages"
     //   case role = "role"
        case avatarUrls = "avatarUrls"
        case expand = "expand"
    }
    
    init(email: String?, session: UserSession?) {
        self.email = email
        self.session = session
    }
    
    init(fromDict dict: [String: Any]) {
        email = dict["email"] as? String
        if let sessionDict = dict["session"] as? [String: Any] {
            self.session = UserSession(fromDict: sessionDict)
        }
    }
    
    
    func toDict() -> [String: Any] {
        var dict = [String: Any]()
        dict[CodingKeys.email.rawValue] = email
        dict[CodingKeys.session.rawValue] = session
        return dict
    
    }
    
    
    func jsonString() throws -> String  {
        return toJSONString()
    }
    
    
    func toJSONString() -> String {
        let dictionary = toDict()
        guard let theJSONData = try?  JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
            return ""
        }
        guard let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) else {
            return ""
        }
        return theJSONText
    }
    
    
    func getImageURL() -> URL? {
        guard let image = avatarUrls?.the48X48 ?? avatarUrls?.the32X32 ?? avatarUrls?.the24X24 ?? avatarUrls?.the16X16 else {
            return nil
        }
        return URL(string: image)
    }
}




class UserSession: Codable {
    var name: String?
    var value: String?
    
    private enum CodingKeys : String, CodingKey {
        case name = "name"
        case value = "value"
    }
    
    init(fromDict dict: [String: Any]) {
        name = dict["name"] as? String
        value = dict["value"] as? String
    }
    
    init(name: String?, value: String?) {
        self.name = name
        self.value = value
    }
}



class AvatarUrls: Codable {
    let the48X48, the24X24, the16X16, the32X32: String

    enum CodingKeys: String, CodingKey {
        case the48X48 = "48x48"
        case the24X24 = "24x24"
        case the16X16 = "16x16"
        case the32X32 = "32x32"
    }
}
