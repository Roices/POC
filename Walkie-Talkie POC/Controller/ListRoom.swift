//
//  ListRoom.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 28/07/2022.
//

import UIKit

class ListRoom: UIViewController {
    // MARK: - Properties
    let listRoomView = UINib(nibName: "ListRoomView", bundle: nil)
        .instantiate(withOwner: Login.self, options: nil)[0] as! ListRoomView
    
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpNavBar()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Setup View
    private func setUpView() {
        listRoomView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: Bound.screenWidth,
                                    height: Bound.screenHeight)
        view.addSubview(listRoomView)
    }
    
    // MARK: - Setup for Controller
    private func setUpForController() {
        //self.listRoomView.
    }
    
    // MARK: - Setup navigation bar
    private func setUpNavBar() {
        self.navigationController?.navigationBar.isHidden = false
        
        title = "Danh sách phòng"
        
        let button = NavCustomButton(image: Image.sideMenu)
        button.backgroundColor = UIColor(hexString: "F5A722")
        button.addTarget(self, action: #selector(didSideMenuTapped), for: .touchUpInside)
        let leftItemBtn = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftItemBtn
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.orange
    }
}

// MARK: - Action
extension ListRoom {
    @objc private func didSideMenuTapped(_ sender: UIButton) {
        
    }
}
