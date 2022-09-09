//
//  ErrorApp.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 06/09/2022.
//
import UIKit

let ERROR_CODE_DEFAULT = 1000
let ERROR_MESSAGE_DEFAULT = NSLocalizedString("An error occurred, please check again", comment: "")

let ERROR_CODE_HTTP = 1001
let ERROR_MESSAGE_HTTP = NSLocalizedString("Connection error, please check your connection and try again", comment: "")

let ERROR_CODE_LOGIN_FAILED = 1002
let ERROR_MESSAGE_LOGIN_FAILED = NSLocalizedString("Incorrect account or password", comment: "")

let ERROR_CODE_PARSER_DATA = 1003
let ERROR_MESSAGE_PARSER_DATA = NSLocalizedString("Error parse data", comment: "")

let ERROR_CODE_SESSION_EXPIRED = 1406
let ERROR_MESSAGE_SESSION_EXPIRED = NSLocalizedString("Your session has expired, please login again", comment: "")

enum ErrorApp: Error {
    
    case httpError
    case defaultError(message: String?)
    case loginFailed(message: String?)
    case parserData
    case sessionExpired(message: String?)
    
    func getCode() -> Int {
        switch self {
        case .defaultError:
            return ERROR_CODE_DEFAULT
            
        case .httpError:
            return ERROR_CODE_HTTP
            
        case .loginFailed:
            return ERROR_CODE_LOGIN_FAILED
    
        case .parserData:
            return ERROR_CODE_PARSER_DATA
            
        case .sessionExpired:
            return ERROR_CODE_SESSION_EXPIRED
        }
        
    }
    
    func getMessage() -> String {
        switch self {
        case .defaultError(message: let message):
            return message ??  ERROR_MESSAGE_DEFAULT
            
        case .httpError:
            return ERROR_MESSAGE_HTTP
            
        case .loginFailed(message: let message):
                return message ?? ERROR_MESSAGE_LOGIN_FAILED
            
        case .parserData:
            return ERROR_MESSAGE_PARSER_DATA
            
        case .sessionExpired(message: let message):
            return message ??  ERROR_MESSAGE_SESSION_EXPIRED

        }
    }
    
    static func parserError(errorData: [String: Any]) -> ErrorApp? {
        
        guard let data = errorData["error"] as? [String: Any] else {
            return nil
        }
 
        let errorMessage = data["message"] as? String
        let errorCode = data["code"] as? Int
        if errorCode == ERROR_CODE_SESSION_EXPIRED {
            return ErrorApp.sessionExpired(message: errorMessage)
        }

        return ErrorApp.defaultError(message: errorMessage)

    }
}
