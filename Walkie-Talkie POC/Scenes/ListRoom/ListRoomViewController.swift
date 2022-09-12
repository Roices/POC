//
//  ListRoom.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 28/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol ListRoomDelegate: NSObject {
    func sideMenuTapped()
}

final class ListRoomViewController: UIViewController {
    

    // MARK: - Properties
    @IBOutlet weak var listRoomTable: UITableView!
    @IBOutlet weak var buttonAddRoom: UIButton!
    weak var delegate: ListRoomDelegate?
    
    private let disposeBag = DisposeBag()
    
    var gestureEnable: Bool = true
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpNavBar()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Setup View
    private func setUpView() {

    }
    
    // MARK: - Setup for Controller
    private func setUpForController() {
    }
    
    // MARK: - Setup navigation bar
    private func setUpNavBar() {
        title = "Danh sách phòng"
        let button = NavCustomButton(image: Image.sideMenu)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(didSideMenuTapped), for: .touchUpInside)
        let leftItemBtn = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftItemBtn
    }
        
}

// MARK: - Action
extension ListRoomViewController {
    @objc func didSideMenuTapped(_ sender: UIButton) {
    }
}


extension ListRoomViewController: StoryboardInstantiable {}
