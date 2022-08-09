//
//  BaseNavigationController.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 09/08/2022.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        UINavigationBar.appearance().barTintColor = AppColor.mainColor
        UINavigationBar.appearance().backgroundColor = AppColor.mainColor
        UIBarButtonItem.appearance().tintColor = AppColor.mainColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }


}
