//
//  UIStoryboardExtension.swift
//  Walkie-Talkie POC
//
//  Created by Macmini2018 on 09/08/2022.
//

import Foundation
import UIKit


extension UIStoryboard {
    func instantiateVC<T: UIViewController>(_ viewControllerType: T.Type) -> T {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: viewControllerType)) as? T else {
            fatalError("Could not instantiateViewController with identifier: \(viewControllerType)")
        }
        return viewController
    }
}

protocol StoryboardInstantiable: UIViewController {}

extension StoryboardInstantiable {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: className, bundle: nil)
        return storyboard.instantiateInitialViewController() as! Self
    }

    static func instantiateWithNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: className, bundle: nil)
        return storyboard.instantiateInitialViewController() as! UINavigationController
    }
}

extension NSObject {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        return type(of: self).className
    }
}
