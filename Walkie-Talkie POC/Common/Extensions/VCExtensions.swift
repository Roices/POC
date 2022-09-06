//
//  VCExtensions.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 28/07/2022.
//

import Foundation
import UIKit


extension UIViewController {
    func hdingKeyboardWhenTappedOut() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponder(_:)))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc func resignFirstResponder(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    // set tab bar image default
    func setTabBarImage(image: UIImage, title: String ,tag: Int){
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = image.withConfiguration(configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    }
    
    //make button with translucent background in navigation bar
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    func setBackButton() {
        let imageBack = UIImage(named: "navbar_close")?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = imageBack
        
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imageBack
        
        /*** If needed Assign Title Here ***/
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    func onTouchBack() {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func showAlert(title: String, message: String) {
       let alertController = UIAlertController(title: title, message:
         message, preferredStyle: .alert)
       alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
       }))
       self.present(alertController, animated: true, completion: nil)
     }

}
