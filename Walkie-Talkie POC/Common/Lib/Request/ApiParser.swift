//
//  ApiParser.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 06/09/2022.
//

import UIKit
import Alamofire

class ApiParser: NSObject {
    
    class func parserResponseString<T:Codable>(response: DataResponse<String>, success:(T) -> (), fail: (ErrorApp) -> ()) {
        guard response.result.isSuccess else {
            fail(ErrorApp.httpError)
            return
        }
        
        if let JSON = response.result.value?.toJSONObject() {
            guard let error = ErrorApp.parserError(errorData: JSON) else {
                guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted) else {
                    fail(ErrorApp.parserData)
                    return
                }
                
                guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                    fail(ErrorApp.parserData)
                    return
                }
                success(result)
                return
            }
            
            fail(error)
        } else {
            fail(ErrorApp.parserData)
        }
    }
    
    class func parserResponseObject<T:Codable>(response: DataResponse<Any>, success:(T) -> (), fail: (ErrorApp) -> ()) {
        guard response.result.isSuccess else {
            fail(ErrorApp.httpError)
            Helper.helper.logout()
            return
        }
        
        if let JSON = response.result.value as? [String: Any] {
            guard let error = ErrorApp.parserError(errorData: JSON) else {
                guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted) else {
                    fail(ErrorApp.parserData)
                    return
                }
                
                guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                    fail(ErrorApp.parserData)
                    return
                }
                success(result)
                return
            }
            
            fail(error)
        } else {
            fail(ErrorApp.parserData)
        }
    }
    
    class func parserResponse<T:Codable>(response: DataResponse<Any>, success:(ApiResult<T>) -> (), fail: (ErrorApp) -> ()) {
        guard response.result.isSuccess else {
            fail(ErrorApp.httpError)
            return
        }
        
        if let JSON = response.result.value as? [String: Any] {
            guard let error = ErrorApp.parserError(errorData: JSON) else {
                guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted) else {
                    fail(ErrorApp.parserData)
                    return
                }
                
                guard let result = try? JSONDecoder().decode(ApiResult<T>.self, from: data) else {
                    fail(ErrorApp.parserData)
                    return
                }
                success(result)
                return
            }
            
            fail(error)
        } else {
            fail(ErrorApp.parserData)
        }
    }
    
    class func parserResponseList<T:Codable>(response: DataResponse<Any>, success:(_ listItem: [T]) -> (), fail: (ErrorApp) -> ()) {
        guard response.result.isSuccess else {
            fail(ErrorApp.httpError)
            return
        }
        
        if let JSON = response.result.value as? [String: Any] {
            guard let error = ErrorApp.parserError(errorData: JSON) else {
                guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted) else {
                    fail(ErrorApp.parserData)
                    return
                }
                
                guard let result = try? JSONDecoder().decode([T].self, from: data) else {
                    fail(ErrorApp.parserData)
                    return
                }
                success(result)
                return
            }
            
            fail(error)
        } else {
            fail(ErrorApp.parserData)
        }
    }
    
    class func parserResponseListPaging<T:Codable>(response: DataResponse<Any>, success:(ApiResultPaging<T>) -> (), fail: (ErrorApp) -> ()) {
        guard response.result.isSuccess else {
            fail(ErrorApp.httpError)
            return
        }
        
        if let JSON = response.result.value as? [String: Any] {
            guard let error = ErrorApp.parserError(errorData: JSON) else {
                guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted) else {
                    fail(ErrorApp.parserData)
                    return
                }
                
                guard let result = try? JSONDecoder().decode(ApiResultPaging<T>.self, from: data) else {
                    fail(ErrorApp.parserData)
                    return
                }
                success(result)
                return
            }
            
            fail(error)
        } else {
            fail(ErrorApp.parserData)
        }
    }
    
}


