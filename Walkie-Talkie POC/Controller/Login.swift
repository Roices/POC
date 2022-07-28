//
//  Login.swift
//  Walkie-Talkie POC
//
//  Created by Tuan on 22/07/2022.
//

import Foundation
import UIKit

class Login: UIViewController {
    
    let loginContentView = UINib(nibName: "LoginView", bundle: nil).instantiate(withOwner: Login.self, options: nil)[0] as! LoginView

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginContentView.frame = CGRect(x: 0, y: 0,
                                        width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height)
        self.view.addSubview(loginContentView)
        
    }
    
    
    
    
}
