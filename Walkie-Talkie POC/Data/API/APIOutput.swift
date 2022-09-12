//
//  APIOutput.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 12/09/2022.
//

import Foundation
import ObjectMapper
import MGAPIService

class APIOutput: APIOutputBase {  // swiftlint:disable:this final_class
    var message: String?
    
    override func mapping(map: Map) {
        message <- map["message"]
    }
}
