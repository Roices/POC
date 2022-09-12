//
//  GetPageDto.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 12/09/2022.
//

import Dto
import ValidatedPropertyKit
import Then

struct GetPageDto: Dto, Then {
    var page = 1
    var perPage = 10
    var usingCache = false
    
    var validatedProperties: [ValidatedProperty] {
        return []
    }
}
