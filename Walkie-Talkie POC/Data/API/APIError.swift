//
//  APIError.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 12/09/2022.
//

import MGAPIService
import Foundation

struct APIExpiredTokenError: APIError {
    var errorDescription: String? {
        return NSLocalizedString("api.expiredTokenError",
                                 value: "Access token is expired",
                                 comment: "")
    }
}

struct APIResponseError: APIError {
    let statusCode: Int?
    let message: String
    
    var errorDescription: String? {
        return message
    }
}
