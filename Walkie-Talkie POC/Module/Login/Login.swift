//
//  Login.swift
//  Walkie-Talkie POC
//
//  Created by Tuan on 22/07/2022.
//

import Foundation
import UIKit

class Login: UIViewController {
    // MARK: - Properties
    private let loginContentView = UINib(nibName: "LoginView", bundle: nil)
        .instantiate(withOwner: Login.self, options: nil)[0] as! LoginView
    
    private let homeVC = UIStoryboard(name: NameConstant.Storyboard.Main,
                                         bundle: nil).instantiateVC(ContainerVC.self)
    
    private let listRoom = UIStoryboard(name: NameConstant.Storyboard.Main,
                                         bundle: nil).instantiateVC(SideMenuController.self)

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpForController()
    }
    
    // MARK: - Setup View
    private func setUpView() {
        loginContentView.frame = CGRect(x: 0, y: 0,
                                        width: Bound.screenWidth,
                                        height: Bound.screenHeight)
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(loginContentView)
    }
    
    // MARK: - Setup for controller
    private func setUpForController() {
        self.navigationController?.navigationBar.isHidden = true
        self.hdingKeyboardWhenTappedOut()
        loginContentView.delegate = self
    }
    
    
}

// MARK: - Delegate from Login
extension Login: LoginViewDelegate {
    // move to forgotPassword view
    func forgotPassword() {
        //
    }
    
    // login Action
    func login(username: String, password: String) {
        print("Login")
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}

// MARK: - Bind Data

