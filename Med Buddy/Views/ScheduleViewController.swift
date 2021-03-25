//
//  ScheduleViewController.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/21/21.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        
        
        setupNavBar()
        
        
    }
    

    
    
    //MARK: - Navigation Bar Setup
    func setupNavBar() {
        configureNavigationBar(largeTitleColor: UIColor(named: K.colors.drugDarkBlue)!, backgoundColor: UIColor.white, tintColor: UIColor(named: K.colors.drugDarkBlue)!, title: "Schedule", preferredLargeTitle: true)
        
        if let navigationBar = self.navigationController?.navigationBar {
            
            // Add Rounded corners
            
            addRoundedCorner(OnNavigationBar: navigationBar, cornerRadius: 25)
            
            // Time Label
            
            addTimeLabel(toNavBar: navigationBar, time: "3:22 PM")
        }
        
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
