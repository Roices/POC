//
//  HttpService.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 09/09/2022.
//

import Alamofire

protocol HttpService {
    var sessionManager: SessionManager { get set }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
