//
//  AppApi.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 06/09/2022.
//
import Foundation

// MARK: - Webservice api comminucation with server

enum ApiHeaderName: String {
    case accessToken = "access_token"
    case secretKey = "secret_key"
    case cookie = "Cookie"
}

enum HeaderContentType: String {
    case applicationJson = "application/json; charset=UTF-8"
    case applicationUrlencoded = "application/x-www-form-urlencoded"
}

enum TransferProtocolType {
    case HTTP
    case HTTPS
}

enum Portable: String {
    case P8088 = ":8088"
    case P8080 = ":8080"
    case none = ""
}

enum PrefixPath: String {
    case api = "api"
    case rest = "rest"
    case restApi = "rest/api"
}

enum ApiType: String {
    case none = ""
    case auth = "auth"
    case googleAuthenticator = "google-authenticator"
}



struct AppApiConstant {

    static var BASE_URL_HTTPS: String {
        get {
            let https = Bundle.main.infoDictionary!["HTTPS_PROTOCOL"] as! String
            let url = Bundle.main.infoDictionary!["BASE_URL_API_ENDPOINT"] as! String
            return "\(https)://\(url)"
        }
    }
    static var BASE_URL_HTTP: String {
        get {
            let http = Bundle.main.infoDictionary!["HTTP_PROTOCOL"] as! String
            let url = Bundle.main.infoDictionary!["BASE_URL_API_ENDPOINT"] as! String
            return "\(http)://\(url)"
        }
    }
    
    static var ACCESS_TOKEN: String {
        get {
            let url = Bundle.main.infoDictionary!["ACCESS_TOKEN"] as! String
            return url
        }
    }
    
    static var SECRET_KEY: String {
        get {
            let url  = Bundle.main.infoDictionary!["SECRET_KEY"] as! String
            return url
        }
    }
    
    static var SERVICE_PATH: String {
          get {
              let url = Bundle.main.infoDictionary!["SERVICE_PATH"] as! String
              return url
          }
    }
    
    static func getUrlRequest(transferProtocolType: TransferProtocolType,
                              port: Portable,
                              prefixPath: PrefixPath,
                              apiType: ApiType,
                              apiName: String,
                              version: String) -> String {
        
        switch transferProtocolType {
        case .HTTP:
            if apiType == .none {
                if version.isEmpty {
                    return BASE_URL_HTTP + port.rawValue + "/" + prefixPath.rawValue + "/" + apiName
                }
                return BASE_URL_HTTP + port.rawValue + "/" + prefixPath.rawValue + "/" + version + "/" + apiName
            }
            if version.isEmpty {
                return BASE_URL_HTTP + port.rawValue + "/" + prefixPath.rawValue + "/" + apiType.rawValue + "/" + apiName
            }
            return BASE_URL_HTTP + port.rawValue + "/" + prefixPath.rawValue + "/" + version + "/" + apiType.rawValue + "/" + apiName
            
        case .HTTPS:
            if apiType == .none {
                if version.isEmpty {
                    return BASE_URL_HTTPS + port.rawValue + "/" + prefixPath.rawValue + "/" + apiName
                }
                return BASE_URL_HTTPS + port.rawValue + "/" + prefixPath.rawValue + "/" + version + "/" + apiName
            }
            if version.isEmpty {
                return BASE_URL_HTTPS + port.rawValue + "/" + prefixPath.rawValue + "/" + apiType.rawValue + "/" + apiName
            }
            return BASE_URL_HTTPS + port.rawValue + "/" + prefixPath.rawValue + "/" + version + "/" + apiType.rawValue + "/" + apiName
        }
    }
    
    
    static func getAuthHeader(contentType: HeaderContentType) -> [String: String] {
        let sessionName = Helper.helper.user?.session?.name ?? "JSESSIONID"
        let sessionValue = Helper.helper.user?.session?.value ?? LocalData.local.getUserSession() ?? ""
        var header = [String: String]()
        header["Content-Type"] = contentType.rawValue
        header["version_app"] = getAppVersionString()
        if !sessionValue.isEmpty {
            header[ApiHeaderName.cookie.rawValue] = sessionName + "=" + sessionValue
        }
        return header
    }
}


