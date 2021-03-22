//
//  ScheduleViewController.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/21/21.
//

import UIKit

class ScheduleViewController: UIViewController, UIPickerViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        configureNavigationBar(largeTitleColor: UIColor(named: K.colors.drugDarkBlue)!, backgoundColor: UIColor.white, tintColor: UIColor(named: K.colors.drugDarkBlue)!, title: "Schedule", preferredLargeTitle: true)
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
