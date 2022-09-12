//
//  API+Room.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 12/09/2022.
//

import ObjectMapper
import RxSwift
import MGAPIService

extension API {
    func getRoomList(_ input: GetRoomListInput) -> Observable<GetRoomListOutput> {
        return request(input)
    }
}

// MARK: - GetRoomList
extension API {
    final class getRoomListInput: APIInput {
        init(page: Int, perPage: Int = 20) {
            let params: JSONDictionary = [
                "q": "language:swift",
                "per_page": perPage,
                "page": page
            ]
            super.init(urlString: API.Urls.getRoomList,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: false)
        }
    }
}
