//
//  SideMenu.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 28/07/2022.
//

import UIKit

class SideMenuController: UIViewController {

    private let sideMenuView = UINib(nibName: "SideMenu", bundle: nil)
        .instantiate(withOwner: Login.self, options: nil)[0] as! SideMenu

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: Bound.screenWidth,
                                    height: Bound.screenHeight)
        
        view.addSubviews(sideMenuView)
        // Do any additional setup after loading the view.
    }
    

}
