//
//  ListRoomModel.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 05/09/2022.
//

import Foundation

struct Room {
    let id: Int
    let roomName: String
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case roomName = "roomName"
    }
}
