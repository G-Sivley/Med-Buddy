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
    
    func addRoundedCorner(OnNavigationBar navigationBar: UINavigationBar, cornerRadius: CGFloat){
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backgroundColor = .white
        
        // just hacked to make look good. Make sure it works on all views
        let customView = UIView(frame: CGRect(x: 0, y: navigationBar.bounds.maxY - 5, width: navigationBar.bounds.width, height: cornerRadius))
        customView.backgroundColor = .clear
        navigationBar.insertSubview(customView, at: 0)
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: customView.bounds, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        
        
        shapeLayer.shadowColor = UIColor.lightGray.cgColor
        shapeLayer.shadowOffset = CGSize(width: -6, height: 6)
        shapeLayer.shadowOpacity = 0.8
        shapeLayer.shadowRadius = 2
        shapeLayer.fillColor = UIColor.white.cgColor
        customView.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    func addTimeLabel(toNavBar navigationBar: UINavigationBar, time: String) {
        let view = UILabel()

        view.frame = CGRect(x: 0, y: 0, width: 130, height: 43)

        view.backgroundColor = .clear

        view.textColor = UIColor(named: K.colors.drugDarkBlue)

        view.font = UIFont(name: "Quicksand-Regular", size: 36)

        // Line height: 45 pt

        view.attributedText = NSMutableAttributedString(string: time, attributes: [NSAttributedString.Key.kern: -1.8])

        navigationBar.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        //view.widthAnchor.constraint(equalToConstant: 130).isActive = true

        view.heightAnchor.constraint(equalToConstant: 43).isActive = true

        view.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -15).isActive = true
    

        view.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 55).isActive = true
    }
}
