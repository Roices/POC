//
//  ApiResultPaging.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 06/09/2022.
//

import Foundation

public class ApiResultPaging<T:Codable>: Codable {
    var data: [T]?
    var page: Int?
    var totalPages: Int?
    var numResults: Int?
    
    private enum CodingKeys : String, CodingKey {
        case data = "data"
        case page = "page"
        case totalPages = "total_pages"
        case numResults = "num_results"
    }
}


public class ApiResult<T:Codable>: Codable {
    var data: T?
}
