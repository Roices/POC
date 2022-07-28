//
//  LoginView.swift
//  Walkie-Talkie POC
//
//  Created by Tuan on 12/06/2022.
//

import UIKit

protocol LoginViewDelegate: NSObject {
    func forgotPassword()
    func login(username: String, password: String)
}

class LoginView: UIView {
    // Outlet
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    weak var delegate: LoginViewDelegate?
    
    // init Function
    override func awakeFromNib() {
        super.awakeFromNib()
      //  username.withImage(direction: .Left, image: Image.person)
      //  password.withImage(direction: .Left, image: Image.password)
    }
    
    // Forgot Action
    @IBAction func forgotPassword() {
        self.delegate?.forgotPassword()
    }
    
    // Login Action
    @IBAction func login() {
        guard let username = username.text,
              let password = password.text else { return }
        //print(username,password)
        self.delegate?.login(username: username, password: password)
    }
    
}

