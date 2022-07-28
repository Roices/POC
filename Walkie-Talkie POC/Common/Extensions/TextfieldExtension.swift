//
//  TextfieldExtension.swift
//  Walkie-Talkie POC
//
//  Created by Tuan on 22/07/2022.
//

import Foundation
import UIKit

extension UITextField {

enum Direction {
    case Left
    case Right
    case Nil
}

// add image to textfield
    func withImage(direction: Direction, image: UIImage?){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        mainView.layer.cornerRadius = 5
        mainView.backgroundColor = .red


        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        mainView.addSubview(view)

    
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)

        let seperatorView = UIView()
        mainView.addSubview(seperatorView)

    
        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 35, y: 0, width: 5, height: 35)
            imageView.image = image
            self.leftViewMode = .always
            self.leftView = mainView
            //setWhenTfIsEmpty()
        } else if(Direction.Right == direction){ // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 35)
            imageView.image = image
            self.rightViewMode = .always
            self.rightView = mainView
            setWhenTfIsEmpty()
        } else if(Direction.Nil == direction){
            mainView.isHidden = true
            imageView.image = nil
            self.rightViewMode = .always
            self.rightView = mainView
            //imageView.backgroundColor = .purple
            view.backgroundColor = .purple
            self.layer.borderWidth = 0.15
            self.layer.borderColor = UIColor.lightGray.cgColor
        }else{
            
        }

            mainView.addSubview(view)
    
 }

    func setWhenTfIsEmpty() {
            self.layer.borderWidth = CGFloat(1)
            self.layer.cornerRadius = 5
            self.layer.borderColor = UIColor.red.cgColor
    }
    
    func setWhenTfIsNotEmpty() {
        self.layer.borderWidth = 0.15
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
}

