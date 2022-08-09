//
//  TableViewExtension.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 09/08/2022.
//

import Foundation
import UIKit

extension UITableView {
    /**
     Function Register Cell Nib.
     - Parameters:
        - cell: class cell Nib.
    */
    func registerCellNib<T: UITableViewCell>(type cell: T.Type) {
        let nib = UINib(nibName: "\(cell.self)", bundle: nil)
        register(nib, forCellReuseIdentifier: "\(cell.self)")
    }
    
    /**
     Function dequeue Reusable Cell Nib.
     - Parameters:
        - cell: class cell Nib.
        - indexPath: Vị trí cell.
    */
    func dequeueReusableCellNib<T: UITableViewCell>(type cell: T.Type, for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withIdentifier: "\(cell.self)", for: indexPath) as? T else {
            Logger.error("Could not dequeue cell with identifier: \(cell.self)")
            return nil
        }
        return cell
    }
}
