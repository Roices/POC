//
//  ListRoomCell.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 31/08/2022.
//

import UIKit

class ListRoomCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var imageAvatar: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelNumberPhone: UILabel!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    // MARK: - SetupView
    private func setupView() {
        imageAvatar.layer.cornerRadius = 20.0
        labelName.text = "Nguyễn Anh Tuấn"
        labelNumberPhone.text = "0966657608"
    }
    
    public func configLabel(name: String, phoneNumber: String) {
        labelName.text = name
        labelNumberPhone.text = phoneNumber
    }
    
    public func configAvatar(urlImage: String) {
        
    }
    
}
