//
//  NavBarExtension.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/22/21.
//

import UIKit

extension UIViewController {
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            
            // change the large title so that the kerning is smaller and the font is different
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor, .font: UIFont(name: "Quicksand Bold", size: 48)!, .kern: -4]
          
            navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.backgroundColor = backgoundColor
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = tintColor
            navigationItem.title = title
            
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = backgoundColor
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
    }
    
    func addShadow(view: UIView, color: CGColor = UIColor.black.cgColor, opacity: Float = 0.2, offset: CGSize = CGSize(width: -6, height: 6), radius: CGFloat = 2) {
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = color
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
        
    }
}
