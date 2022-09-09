//
//  ListRoomAPI.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 09/09/2022.
//

import RxSwift

protocol ListRoomAPI {
    func fetchListRoom() -> Single<[Room]>
}
