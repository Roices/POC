//
//  ListRoom.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 28/07/2022.
//

import UIKit

protocol ListRoomDelegate: NSObject {
    func sideMenuTapped()
}

final class ListRoomViewController: UIViewController {
    // MARK: - Properties
    private let listRoom = UINib(nibName: "ListRoomView", bundle: nil)
        .instantiate(withOwner: Login.self, options: nil)[0] as! ListRoomView
    weak var delegate: ListRoomDelegate?
    
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
        listRoom.frame = CGRect(x: 0,
                                y: 0,
                                width: Bound.screenWidth,
                                height: Bound.screenHeight)
        view.addSubviews(listRoom)
    }
    
    // MARK: - Setup for Controller
    private func setUpForController() {
        //self.listRoomView.
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
        print("tapped")
        self.delegate?.sideMenuTapped()
    }
}


// MARK: - BindData
extension ListRoomViewController {
    
}
