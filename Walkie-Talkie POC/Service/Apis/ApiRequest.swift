//
//  ApiRequest.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 06/09/2022.
//

import Foundation
import UIKit
import Alamofire


enum ApiRequestType {
    case post
    case get
    case upload
    case put
}

class ApiRequest: ApiCommand {
    
    var type: ApiRequestType = .get
    var params: [String: Any] = [:]
    var header: [String: String] = AppApiConstant.getAuthHeader(contentType: HeaderContentType.applicationJson)
    var urlRequest = ""
    var image: UIImage?

    
    init(urlRequest: String, type: ApiRequestType) {
        self.urlRequest = urlRequest
        self.type = type
    }
    
    func getParam() -> [String: Any] {
        return params
    }
    
    // MARK: response List Object paging
    func excuteWithResponseListPaging<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        self.params = getParam()
               debugPrint("---------------- request ---------------")
               debugPrint("url: ", urlRequest)
               debugPrint("param: ", self.params)
               debugPrint("header: ", self.header)
               debugPrint("Type: ", self.type)

               switch type {
               case .get:
                   GETWithResponseListPaging(success: success, fail: fail)
                   
               case .post:
                   POSTWithResponseListPaging(success: success, fail: fail)
                   
               case .upload:
                   uploadImageWithResponseListPaging(image: image!, success: success, fail: fail)
                   
               case .put:
                   PUTWithResponseListPaging(success: success, fail: fail)

                   break
               }
    }
    
    func PUTWithResponseListPaging<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .put,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseListPaging(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func POSTWithResponseListPaging<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {

        let request = Alamofire.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseListPaging(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
    
    func GETWithResponseListPaging<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        header["Content-Type"] = nil
        let request = Alamofire.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseListPaging(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
        
    func uploadImageWithResponseListPaging<T:Codable>(image: UIImage, success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let imageData = image.pngData()!
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            let fileName = "image.png"
            let name = "image_data"
            let mimeType = "png"
            multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType)
                },
                         usingThreshold:UInt64.init(),
                         to:urlRequest,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                
                                upload.responseString(completionHandler: { (response) in
                                    print("responseString: \(response)")
                                })
                                
                                upload.responseJSON { response in
                                    ApiParser.parserResponseListPaging(response: response,
                                                            success: success,
                                                            fail: fail)
                                }
                            case .failure(let encodingError):
                                fail(ErrorApp.httpError)
                                print("uploadError: " + encodingError.localizedDescription)
                            }
        })
    }

    // MARK: response List Object
    func excuteWithResponseList<T:Codable>(success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ()) {
        self.params = getParam()
               debugPrint("---------------- request ---------------")
               debugPrint("url: ", urlRequest)
               debugPrint("param: ", self.params)
               debugPrint("header: ", self.header)
               debugPrint("Type: ", self.type)

               switch type {
               case .get:
                   GETWithResponseList(success: success, fail: fail)
                   
               case .post:
                   POSTWithResponseList(success: success, fail: fail)
                   
               case .upload:
                   uploadImageWithResponseList(image: image!, success: success, fail: fail)
                   
               case .put:
                   PUTWithResponseList(success: success, fail: fail)

                   break
               }
    }
    
    func PUTWithResponseList<T:Codable>(success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .put,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseList(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func POSTWithResponseList<T:Codable>(success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ()) {

        let request = Alamofire.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseList(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
    
    func GETWithResponseList<T:Codable>(success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseList(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
        
    func uploadImageWithResponseList<T:Codable>(image: UIImage, success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let imageData = image.pngData()!
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            let fileName = "image.png"
            let name = "image_data"
            let mimeType = "png"
            multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType)
                },
                         usingThreshold:UInt64.init(),
                         to:urlRequest,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                
                                upload.responseString(completionHandler: { (response) in
                                    print("responseString: \(response)")
                                })
                                
                                upload.responseJSON { response in
                                    ApiParser.parserResponseList(response: response,
                                                            success: success,
                                                            fail: fail)
                                }
                            case .failure(let encodingError):
                                fail(ErrorApp.httpError)
                                print("uploadError: " + encodingError.localizedDescription)
                            }
        })
    }
    
    //MARK: - Response Object containt Data
    func excute<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        self.params = getParam()
        debugPrint("---------------- request ---------------")
        debugPrint("url: ", urlRequest)
        debugPrint("param: ", self.params)
        debugPrint("header: ", self.header)
        debugPrint("Type: ", self.type)

        switch type {
        case .get:
            GET(success: success, fail: fail)
            
        case .post:
            POST(success: success, fail: fail)
            
        case .upload:
            uploadImage(image: image!, success: success, fail: fail)
            
        case .put:
            PUT(success: success, fail: fail)

            break
        }
    }
    
    
    func PUT<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .put,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponse(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func POST<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {

        let request = Alamofire.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponse(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
    
    func GET<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponse(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
    
    
    func DELETE<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .delete,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponse(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
    
    
    
    public func excuteURLEncoding<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        self.params = getParam()
        debugPrint("---------------- request ---------------")
        debugPrint("url: ", urlRequest)
        debugPrint("param: ", self.params)
        debugPrint("header: ", self.header)
        debugPrint("Type: ", self.type)
        
        switch type {
        case .get:
            GETURLEncoding(success: success, fail: fail)
            
        case .post:
            POSTURLEncoding(success: success, fail: fail)
            
        case .upload:
            break
            
        case .put:
            PUTURLEncoding(success: success, fail: fail)
            
            break
        }
    }
    
    func PUTURLEncoding<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .put,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponse(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func POSTURLEncoding<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponse(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func GETURLEncoding<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponse(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    
    public func excuteWithPagingURLEncoding<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        self.params = getParam()
        debugPrint("---------------- request ---------------")
        debugPrint("url: ", urlRequest)
        debugPrint("param: ", self.params)
        debugPrint("header: ", self.header)
        debugPrint("Type: ", self.type)
        
        switch type {
        case .get:
            GETURLPagingEncoding(success: success, fail: fail)
            
        case .post:
            POSTURLPagingEncoding(success: success, fail: fail)
            
        case .upload:
            break
            
        case .put:
            PUTURLPagingEncoding(success: success, fail: fail)
            
            break
        }
    }
    
    func PUTURLPagingEncoding<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .put,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseListPaging(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func POSTURLPagingEncoding<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseListPaging(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func GETURLPagingEncoding<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseListPaging(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    
    
    
    //MARK: - Response Object
    func excuteWithObject<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {
        self.params = getParam()
        debugPrint("---------------- request ---------------")
        debugPrint("url: ", urlRequest)
        debugPrint("param: ", self.params)
        debugPrint("header: ", self.header)
        debugPrint("Type: ", self.type)

        switch type {
        case .get:
            GETWithObject(success: success, fail: fail)
            
        case .post:
            POSTWithObject(success: success, fail: fail)
            
        case .upload:
            uploadImage(image: image!, success: success, fail: fail)
            
        case .put:
            PUTWithObject(success: success, fail: fail)

            break
        }
    }
    
    func PUTWithObject<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .put,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseObject(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func POSTWithObject<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {

        let request = Alamofire.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseObject(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
    
    func GETWithObject<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseObject(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
        
    func uploadImage<T:Codable>(image: UIImage, success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let imageData = image.pngData()!
        Alamofire.upload(multipartFormData:{ multipartFormData in
            let fileName = "image.png"
            let name = "image"
            let mimeType = "png"
            multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType)
                },
                         usingThreshold:UInt64.init(),
                         to:urlRequest,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                
                                upload.responseString(completionHandler: { (response) in
                                    print("responseString: \(response)")
                                    ApiParser.parserResponseString(response: response,
                                                            success: success,
                                                            fail: fail)
                                })
                                
                                upload.responseJSON { response in
                                    ApiParser.parserResponseObject(response: response,
                                                            success: success,
                                                            fail: fail)
                                }
                            case .failure(let encodingError):
                                fail(ErrorApp.httpError)
                                print("uploadError: " + encodingError.localizedDescription)
                            }
        })
    }
}

struct JSONStringArrayEncoding: ParameterEncoding {
    private let array: [String]
    
    init(array: [String]) {
        self.array = array
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        let data = try JSONSerialization.data(withJSONObject: parameters ?? [:], options: [])
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
}



