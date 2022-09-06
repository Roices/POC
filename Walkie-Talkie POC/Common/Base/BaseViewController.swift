//
//  BaseViewController.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 31/08/2022.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2, width: 45, height: 45), type: .ballSpinFadeLoader, color:  AppColor.mainColor)

    let labelStateData = UILabel()
    let textView = UITextView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.setBackButton()
        setupLabel()
        setupBackground()
        setupHideKeyboardOnTap()
        setupLoadingIndicator()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func push(viewcontroller: UIViewController) {
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupLoadingIndicator() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicatorView)
        self.view.addConstraints([NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
                                  NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: -100)])
        
    }
    
    func showAlertWithTitle(_ title: String, withMessage message: String, actionOK: UIAlertAction?, actionCancel: UIAlertAction?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertActionOk = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        if actionOK == nil {
            alertController.addAction(alertActionOk)
        }else{
            alertController.addAction(actionOK!)
        }
        
        if let cancel = actionCancel {
            alertController.addAction(cancel)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    
//    func showError(error: ErrorApp, message: String?) {
//        if error.getCode() == ErrorApp.httpError.getCode() {
//            self.showAlertWithTitle(NSLocalizedString("Thông báo", comment: ""), withMessage: error.getMessage(), actionOK: nil, actionCancel: nil)
//        } else {
//            self.showAlertWithTitle(NSLocalizedString("Thông báo", comment: ""), withMessage: message ?? error.getMessage(), actionOK: nil, actionCancel: nil)
//        }
//    }
    

    func showIndicatorLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.view.bringSubviewToFront(self!.activityIndicatorView)
            self?.activityIndicatorView.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    func hideIndicatorLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    func setupBackground() {
        let imageBkg1 = UIImage(named: "imageBkg1")
        let imageBackgroundTop = UIImageView(image: imageBkg1)
        
        
        let imageBkg2 = UIImage(named: "imageBkg2")
        let imageBackgroundBottom = UIImageView(image: imageBkg2)
        
        let dict = ["imageBackgroundTop": imageBackgroundTop, "imageBackgroundBottom": imageBackgroundBottom] as [String: UIView]
        self.view.addSubview(imageBackgroundTop)
        self.view.addSubview(imageBackgroundBottom)
        
//        self.view.addConstraints(constraintsVFL: "H:|-0-[imageBackgroundTop]", views: dict)
//        self.view.addConstraints(constraintsVFL: "V:|-0-[imageBackgroundTop]", views: dict)
//        self.view.addConstraints(constraintsVFL: "H:[imageBackgroundBottom]-0-|", views: dict)
//        self.view.addConstraints(constraintsVFL: "H:[imageBackgroundBottom]-0-|", views: dict)
    }
    
    
    func setupLabel() {
        labelStateData.textColor = UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1)
        labelStateData.numberOfLines = 0
        labelStateData.font = UIFont(name: "SanFranciscoDisplay-Regular", size: 15)
        labelStateData.isHidden = true
        labelStateData.numberOfLines = 0
        labelStateData.textAlignment = .center
        labelStateData.text = NSLocalizedString("Chưa có dữ liệu", comment: "")
        labelStateData.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.bringSubviewToFront(labelStateData)
        self.view.addSubview(labelStateData)
        
        let dict = ["label": labelStateData]
//        self.view.addConstraints(constraintsVFL: "H:|-20-[label]-20-|", views: dict)
        let cTrainst = NSLayoutConstraint(item: labelStateData, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 60)
        self.view.addConstraint(cTrainst)
//        self.view.addConstraints(constraintsVFL: "V:|-50-[label]", views: dict)
    }
    
    func displayNoData() {
        labelStateData.isHidden = false
    }
    
    func hideNoData()  {
        labelStateData.isHidden = true
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "shadow_header_search")
    }
    
    func addButtonBack() {
        let iconClose = UIImage(named: "navbar_back_white")?.withRenderingMode(.alwaysOriginal)
        let leftbarButton = UIBarButtonItem(image: iconClose, style: .plain, target: self, action: #selector(closeView))
        self.navigationItem.leftBarButtonItem = leftbarButton
    }
    
    
    func showTextView(title: String, text: String, onSubmit: @escaping (_ value: String)->()) {
        showIndicatorLoading()
        let alertController = UIAlertController(title: title + "\n\n\n\n\n", message: nil, preferredStyle: .alert)

        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
            self.textView.text = ""
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            let enteredText = self.textView.text ?? ""
            onSubmit(enteredText)
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(saveAction)
        
        alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
        textView.text = text
        textView.backgroundColor = UIColor.white
        textView.layer.cornerRadius = 10
        textView.textColor = UIColor(red: 0.212, green: 0.212, blue: 0.212, alpha: 1)
        textView.font = UIFont(name: "SanFranciscoDisplay-Medium", size: 13)
        if #available(iOS 11.0, *) {
            textView.smartQuotesType = .no
            textView.smartDashesType = .no
            textView.smartInsertDeleteType = .no
        }
        textView.spellCheckingType = .no
        textView.autocorrectionType = .no
        textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 5, bottom: 8, right: 5)
        alertController.view.addSubview(self.textView)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                let margin: CGFloat = 8
                let xPos = rect.origin.x + margin
                let yPos = rect.origin.y + 54
                let width = rect.width - 2 * margin
                let height: CGFloat = 90
                textView.becomeFirstResponder()
                textView.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
            }
        }
        hideIndicatorLoading()
    }
    
    
    
    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
