//
//  GettingRoomList.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 12/09/2022.
//

import RxSwift
import MGArchitecture
import UIKit

protocol GettingRoomList {
    var roomGateway: RoomGatewayType { get }
}

extension GettingRoomList {
    func getRoomList(dto: GetPageDto) -> Observable<PagingInfo<Room>> {
        return roomGateway.getRoomList(dto: dto)
    }
}
