//
//  ListRoomService.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 09/09/2022.
//

import Alamofire
import RxSwift
import RxCocoa

class ListRoomService {
    private lazy var listRoomHttpService = ListRoomHttpService()
    static let shared: ListRoomService = ListRoomService()
}

extension ListRoomService: ListRoomAPI {
    
    func fetchListRoom() -> Single<[Room]> {
        return Single.create { [self] (single) -> Disposable in
            do {
                try ListRoomHttpRouter.getListRoom
                    .request(usingHttpService: listRoomHttpService)?
                    .responseJSON(completionHandler: { (result) in
                        
                        guard let data = result.data else { return }
                        do {
                            let roomData = try JSONDecoder().decode([Room].self, from: data)
                            print(roomData)
                            single(.success(roomData))
                        } catch {
                            
                        }
                    })
            } catch {
                
            }
            return Disposables.create()
        }
    }
}

