//
//  ListRoomViewModel.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 31/08/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Action 

protocol ListRoomViewModelInputs {
    var sideMenuTapped: PublishSubject<Void> { get }
    var pullToRefresh : PublishSubject<Void> { get }
    var cellDidTouch  : PublishSubject<Void> { get }
    var addDidTouch   : PublishSubject<Void> { get }
}

protocol ListRoomViewModelOutputs {
  //  var sideMenuStatus: Observable<Bool> { get }
    var listRoomData: Observable<[Room]> { get }
    var isLoading: Observable<Bool> { get }
    var error: Observable<NSError> { get }
}

protocol ListRoomModelType{
    var inputs: ListRoomViewModelInputs { get }
    var outputs: ListRoomViewModelOutputs { get }
}

final class ListRoomViewModel: ListRoomModelType, ListRoomViewModelInputs, ListRoomViewModelOutputs {
    
    var inputs : ListRoomViewModelInputs { return self }
    var outputs: ListRoomViewModelOutputs { return self }
    
    // MARK: - Inputs
    var sideMenuTapped = PublishSubject<Void>()
    var pullToRefresh  = PublishSubject<Void>()
    var cellDidTouch   = PublishSubject<Void>()
    var addDidTouch    = PublishSubject<Void>()
    private let page   = BehaviorRelay<Int>(value: 1)
    
    // MARK: - Outputs
  //  var sideMenuStatus: Observable<Bool>
    var listRoomData  : Observable<[Room]>
    var isLoading     : Observable<Bool>
    var error         : Observable<NSError>
    
    private let disposeBag = DisposeBag()
    private let searchAction: Action<Int, [Room]>

    init() {
        self.searchAction = Action { page in
            return ListRoomService.shared.fetchListRoom()
        }
        let response = BehaviorRelay<[Room]>(value: [])
        self.listRoomData = response.asObservable()
        self.isLoading = searchAction.executing.startWith(false)
        
        self.error = searchAction.errors.map{ _ in NSError(domain: "Network Error", code: 0, userInfo: nil)}
    
        searchAction.elements
            .withLatestFrom(response) { ($0, $1) }
            .map { $0.1 + $0.0 }
            .bind(to: response)
            .disposed(by: disposeBag)
        
        searchAction.elements
            .withLatestFrom(page)
            .map { $0 + 1 }
            .bind(to: page)
            .disposed(by: disposeBag)
        
        cellDidTouch.withLatestFrom(page)
            .bind(to: searchAction.inputs)
            .disposed(by: disposeBag)
        
        pullToRefresh.withLatestFrom(isLoading)
            .filter { !$0 }
            .withLatestFrom(page)
            .filter { $0 < 5 }
            .bind(to: searchAction.inputs)
            .disposed(by: disposeBag)
    }
    
}
