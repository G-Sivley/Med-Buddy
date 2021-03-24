//
//  ScheduleViewController.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/21/21.
//

import UIKit
import JTAppleCalendar

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

extension ScheduleViewController: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

extension ScheduleViewController: JTACMonthViewDelegate {
    
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        cell.dateLabel.text = cellState.text
        return cell
    }
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! DateCell
        cell.dateLabel.text = cellState.text
    }
    
    
}
