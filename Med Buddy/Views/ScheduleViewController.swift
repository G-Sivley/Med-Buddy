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
        configureNavigationBar(largeTitleColor: UIColor(named: K.colors.drugDarkBlue)!, backgoundColor: UIColor.white, tintColor: UIColor(named: K.colors.drugDarkBlue)!, title: "Schedule", preferredLargeTitle: true)
        
        if let navigationBar = self.navigationController?.navigationBar {
            
            // Add Rounded corners
            
            // Add Shadows
            
    
            
            
            // Time Label
            
            let view = UILabel()

            view.frame = CGRect(x: 0, y: 0, width: 130, height: 43)

            view.backgroundColor = .clear

            view.textColor = UIColor(named: K.colors.drugDarkBlue)

            view.font = UIFont(name: "Quicksand-Regular", size: 36)


            // Line height: 45 pt


            view.attributedText = NSMutableAttributedString(string: "3:22 PM", attributes: [NSAttributedString.Key.kern: -1.8])

            navigationBar.addSubview(view)

            view.translatesAutoresizingMaskIntoConstraints = false

            //view.widthAnchor.constraint(equalToConstant: 130).isActive = true

            view.heightAnchor.constraint(equalToConstant: 43).isActive = true

            view.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -15).isActive = true
        

            view.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 55).isActive = true
        }
        
        
    }
 
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
