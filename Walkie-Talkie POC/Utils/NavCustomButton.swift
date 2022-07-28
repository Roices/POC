//
//  File.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 28/07/2022.
//

import Foundation
import UIKit
class NavCustomButton: UIButton {
    // MARK: - Subview
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    convenience init(image: UIImage) {
        self.init(frame: .zero)
        setImage(image, for: .normal)
//        imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        tintColor = .blue
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //give default size, if they put into stackview, this view will know how to size itself
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: 200, height: 200)
//    }
    
    // MARK: - Selector
    
    // MARK: - API
    
    // MARK: - Helper
}
// MARK: - Extension

extension NavCustomButton {
    private func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 5
        backgroundColor = .white
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 32),
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1)
        
        ])
    }
}
