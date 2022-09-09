//
//  ApiCommand.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 06/09/2022.
//

import Foundation


protocol ApiCommand {
    func excuteWithResponseList<T:Codable>(success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ())
    func excuteWithResponseListPaging<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ())
    func excute<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ())
    func excuteWithObject<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ())
}
