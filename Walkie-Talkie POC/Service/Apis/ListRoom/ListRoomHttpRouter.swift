//
//  ListRoomHttpRouter.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 09/09/2022.
//

import Alamofire

enum ListRoomHttpRouter {
    case getListRoom
    case deleteListRoom
    case putListRoom
    case postListRoom
}

extension ListRoomHttpRouter: HttpRouter {
    
    var baseUrlString: String {
        return "https://631552b05b85ba9b11de5134.mockapi.io"
    }
    
    var path: String {
        switch self {
        case .getListRoom:
            return "/Room"
        default:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getListRoom:
            return .get
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    func body() throws -> Data? {
        return nil
    }
    
    func request(usingHttpService service: HttpService) throws -> DataRequest? {
        return nil
    }
    
    
}
