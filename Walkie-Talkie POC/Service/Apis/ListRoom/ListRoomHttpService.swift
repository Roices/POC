//
//  ApiListRoom.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 06/09/2022.
//

import Alamofire

class ListRoomHttpService: HttpService {
    var sessionManager: SessionManager = SessionManager.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
    
    
}
