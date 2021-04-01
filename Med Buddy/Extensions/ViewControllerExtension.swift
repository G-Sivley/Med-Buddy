//
//  NavBarExtension.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/22/21.
//

import UIKit

extension UIViewController {
    func addShadow(view: UIView, color: CGColor = UIColor.black.cgColor, opacity: Float = 0.2, offset: CGSize = CGSize(width: -6, height: 6), radius: CGFloat = 2) {
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = color
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
        
    }
}
