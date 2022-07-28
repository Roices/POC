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
    
//    //show custom alert vc
//    func presentAlertOnMainThread(content: String, selection: AlertSelection, completion: @escaping(AlertViewController)->Void){
//        DispatchQueue.main.async {
//            let alertVC = AlertViewController(content: content, selection: selection)
//            alertVC.modalTransitionStyle = .crossDissolve
//            alertVC.modalPresentationStyle = .overFullScreen
//            
//            self.present(alertVC, animated: true, completion: nil)
//            completion(alertVC)
//        }
//    }
    
//    func presentAlertNoOptionOnMainThread(content: String, completion: @escaping(AlertNoOptionViewController) -> Void){
//        let alertVC = AlertNoOptionViewController(content: content)
//        alertVC.modalTransitionStyle = .crossDissolve
//        alertVC.modalPresentationStyle = .overFullScreen
//
//        self.present(alertVC, animated: true, completion: nil)
//        completion(alertVC)
//    }
//
//    func configBackButtonNavBar(){
//        
//        let button = NavCustomButton(image: Image.back)
//        button.addTarget(self, action: #selector(didBackButtonTapped(_:)), for: .touchUpInside)
//        let leftItemButton = UIBarButtonItem(customView: button)
//        self.navigationItem.leftBarButtonItem = leftItemButton
//    }
    
    @objc func didBackButtonTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
//    func showToast(message : String, font: UIFont) {
//        let width = message.widthOfText(font: font) + 16
//        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - (width / 2), y: 8, width: width, height: 35))
//        toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.8)
//        toastLabel.textColor = UIColor.redTY
//        toastLabel.font = font
//
//        toastLabel.textAlignment = .center;
//        toastLabel.text = message
//        toastLabel.alpha = 1.0
//        toastLabel.layer.cornerRadius = 10;
//        toastLabel.clipsToBounds  =  true
//        self.view.addSubview(toastLabel)
//
//        UIView.animate(withDuration: 8.0, delay: 0.1, options: .curveEaseOut, animations: {
//            toastLabel.alpha = 0.0
//        }, completion: {(isCompleted) in
//            toastLabel.removeFromSuperview()
//        })
//    }
    
    func showAlert(title: String, message: String) {
       let alertController = UIAlertController(title: title, message:
         message, preferredStyle: .alert)
       alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
       }))
       self.present(alertController, animated: true, completion: nil)
     }

}
