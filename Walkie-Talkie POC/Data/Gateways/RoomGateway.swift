//
//  RoomGateway.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 12/09/2022.
//

import Foundation
import RxSwift
import MGArchitecture

protocol RoomGatewayType {
    func getRoomList(dto: GetPageDto) -> Observable<PagingInfo<Room>>
}

struct RoomGateway: RoomGatewayType {
    func getRoomList(dto: GetPageDto) -> Observable<PagingInfo<Room>> {
        let (page, perPage, usingCache) = (dto.page, dto.perPage, dto.usingCache)
        
        let input = API
    }
}
