//
//  ScheduleTableViewController.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/27/21.
//

import UIKit

class ScheduleTableViewController: UITableViewController {

    let medicationsArray = ["Fluoxetine", "Prasugrel", "Ibuprofen"]
    
    let timeLabel = TimeLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        
        
        // Register and setup medication table
        registerNibs()
        
        // Setup NavBar
        setupNavBar()
    }
    
    //MARK: - Navigation Bar Setup
    func setupNavBar() {
        configureNavigationBar(largeTitleColor: UIColor(named: K.Colors.drugDarkBlue)!, backgoundColor: UIColor.white, tintColor: UIColor(named: K.Colors.drugDarkBlue)!, title: "Schedule", preferredLargeTitle: true)
    
        if let navigationBar = self.navigationController?.navigationBar {
            timeLabel.setupTimeLabel(on: navigationBar)
            addShadow(view: navigationBar)
        }
    }
    
    
    //MARK: - TableView Setup
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Nibs.calendarReusableCell)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 335
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Nibs.timeOfDayReusableCell, for: indexPath) as! TimeOfDayCell
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Nibs.medicationReusableCell, for: indexPath) as! MedicationTableViewCell
            return cell
            
        }
    }

    func registerNibs() {
        let medicationCellNib = UINib.init(nibName: K.Nibs.medicationNib, bundle: nil)
        self.tableView.register(medicationCellNib, forCellReuseIdentifier: K.Nibs.medicationReusableCell)
        
        let calenderCellNib = UINib.init(nibName: K.Nibs.calendarNib, bundle: nil)
        self.tableView.register(calenderCellNib, forCellReuseIdentifier: K.Nibs.calendarReusableCell)
        
        let timeOfDayCellNib = UINib.init(nibName: K.Nibs.timeOfDayNib, bundle: nil)
        self.tableView.register(timeOfDayCellNib, forCellReuseIdentifier: K.Nibs.timeOfDayReusableCell)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Scroll Methods
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        timeLabel.moveAndResizeLabel(for: height)
    }
}
