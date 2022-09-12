//
//  ContainerVC.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 09/08/2022.
//

import UIKit

class ContainerVC: BaseViewController {
    
    // MARK: - SubView & Properties
    var listRoomView = UIStoryboard(name: NameConstant.Storyboard.Main,
                                                        bundle: nil).instantiateVC(ListRoomViewController.self)

    var SideMenuView = UIStoryboard(name: NameConstant.Storyboard.Main,
                                                        bundle: nil).instantiateVC(SideMenuController.self)
    var navigationVC: UINavigationController!
    
    // properties
    enum SideMenuStatus {
        case opened
        case closed
    }
    
    private var sideMenuStatus: SideMenuStatus = .closed
    static let sideMenuPadding: CGFloat = Bound.screenWidth * 0.6

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addChildVCs()
        setupView()
    }
    
    // MARK: Add subviews
     private func addChildVCs() {
         // sidemenuVC
         SideMenuView.view.frame.origin.x = 0
         SideMenuView.view.frame.size.width = Bound.screenWidth * 0.6
         addChild(SideMenuView)
         view.addSubview(SideMenuView.view)
         SideMenuView.didMove(toParent: self)
         
         //homeVc
         let navVC = UINavigationController(rootViewController: listRoomView)
         addChild(navVC)
         view.addSubview(navVC.view)
         navVC.didMove(toParent: self)
         self.navigationVC = navVC
     }
    
    // MARK: setupView()
    private func setupView() {
        listRoomView.delegate = self
    }
}

extension ContainerVC: ListRoomDelegate {
    func sideMenuTapped() {
        print("tapped")
        switch sideMenuStatus {
        case .opened:
            //close it
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) {
                self.navigationVC.view.frame.origin.x = 0
            } completion: { [weak self] done in
                guard let self = self else {return}
                if done{
                    self.sideMenuStatus = .closed
                }
            }
        case .closed:
            //open it
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) {
                self.navigationVC.view.frame.origin.x = ContainerVC.sideMenuPadding
            } completion: { [weak self] done in
                guard let self = self else {return}
                if done{
                    self.sideMenuStatus = .opened
                }
            }
        }

    }
    
    
}
