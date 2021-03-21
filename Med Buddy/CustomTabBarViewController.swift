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
        
        
    }
    
    override func viewWillLayoutSubviews() {
        let buttonWidth = UIScreen.main.bounds.width / 5
        let buttonX = buttonWidth * 2
        let buttonY = (tabBar.frame.height / 3) * -1
        
        let button = UIButton(frame: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonWidth))
        
        // Currently need to add Plus button image and the button functionality
        
        button.layer.cornerRadius = buttonWidth / 2
        button.backgroundColor = UIColor(named: K.colors.drugOrange)
        button.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        
        tabBar.addSubview(button)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

 
}

