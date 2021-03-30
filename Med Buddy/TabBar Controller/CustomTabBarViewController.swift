//
//  CustomTabBarViewController.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/21/21.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBar.unselectedItemTintColor = UIColor(named: K.Colors.drugBackgroundGrey)
        tabBar.tintColor = UIColor(named: K.Colors.drugDarkBlue)
        
    }
    
    override func viewWillLayoutSubviews() {
        addCircleButton()
    }
    
    
    
    // Creates the circle add button on the tab bar
    func addCircleButton() {
        
        let buttonWidth = UIScreen.main.bounds.width / 5
        // x starts after the second button
        let buttonX = buttonWidth * 2
        
        // y starts 1/3 the way up the tab bar
        var buttonY = (tabBar.frame.height / 3) * -1
        
        // if the the radius / 4 > button Y, the button y needs to be higher so that the circle is not cut off on the new phone.
        if (buttonWidth / 4) > (buttonY * -1) {
            buttonY = (tabBar.frame.height / 1.5) * -1
        }
        
        // Creates button and sets it in the correct location
        let button = UIButton(frame: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonWidth))
        
        // makes button circular
        button.layer.cornerRadius = buttonWidth / 2
        button.backgroundColor = UIColor(named: K.Colors.drugOrange)

        // sets configuration and places + image
        let thinConfiguration = UIImage.SymbolConfiguration(weight: .thin)
        button.setImage(UIImage(systemName: "plus", withConfiguration: thinConfiguration), for: .normal)
        
        // aligns the image within the button with equal insets on all sides
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        let imageInsets = buttonWidth / 3.5
        button.imageEdgeInsets = UIEdgeInsets(top: imageInsets, left: imageInsets, bottom: imageInsets, right: imageInsets)
        
        // creates action for the button
        button.addTarget(self, action: #selector(circleButtonTapped), for: .touchUpInside)
        
        tabBar.addSubview(button)
        
    }
    
    @objc func circleButtonTapped() {
        // prepare for segue in the future if necessary
        
        performSegue(withIdentifier: "add", sender: self)
    }
}

