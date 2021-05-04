//
//  ScheduleTableViewController.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/27/21.
//

import UIKit
import Firebase

class ScheduleTableViewController: UITableViewController {
    
    let timeLabel = TimeLabel()
    
    var listBrain = ListBrain()
    
    let numberOfNonMedicationCells = 3
    
    var img: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register and setup medication table
        registerNibs()
        
        // Setup NavBar
        setupNavBar()
        
        loadList()
        
        listBrain.delegate = self
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: - Navigation Bar Setup
    func setupNavBar() {
        // Setup for large title
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        
        // Setup for standard title
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor(named: K.Colors.drugBackgroundGrey)
    
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.standardAppearance = standardAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
            timeLabel.setupTimeLabel(on: navigationBar)
        }
    }
    
    
    //MARK: - TableView Setup
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // height of addMedButton
        if indexPath.row == 0 {
            return 45
        } else if indexPath.row == 1 {
            // height of calendar
            return 335
        } else {
            // height of rest of rows (automatic)
            return tableView.rowHeight
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Number of cells plus medications
        
        return numberOfNonMedicationCells + listBrain.medicationList.count
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Add button location
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.addMedCell) as! AddMedButtonTableViewCell
            
            cell.delegate = self
            cell.indexPath = indexPath
            return cell
        }
        // Calendar Location
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.calendarReusableCell) as! CalendarTableViewCell
            
            return cell
        }
        // Divider cell location
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.timeOfDayReusableCell, for: indexPath) as! TimeOfDayCell
            return cell
            
        }
        
        // standard med cell
        else {
            
            // This could be problematic if there is a medication before a non medication cell.
            let medication = listBrain.medicationList[indexPath.row - numberOfNonMedicationCells]
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.medicationReusableCell, for: indexPath) as! MedicationTableViewCell
            
            
            cell.medicationNameLabel.text = medication.name
            
            
            // This works as expected, but has major code smell. I will refactor to ensure that we are not loading the images multiple times during table initializations.
            let storageRef = Storage.storage().reference(withPath: "medications/F1711963-E131-4102-AEFB-992057CAA484.jpg")
            storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
                if let e = error {
                    print("Got an error fetching data: \(e.localizedDescription)")
                    return
                } else {
                    if let data = data {
                        DispatchQueue.main.async {
                            if let imgFromData = UIImage(data: data) {
                                cell.medicationImg.image = imgFromData
                                print("Image Associated")
                                
                            }
                        }
                    }
                }
            }
            

            
            return cell
            
        }
    }
    
    //MARK: - Nib Registration
    
    func registerNibs() {
        let medicationCellNib = UINib.init(nibName: K.Cells.medicationNib, bundle: nil)
        self.tableView.register(medicationCellNib, forCellReuseIdentifier: K.Cells.medicationReusableCell)
        
        let calenderCellNib = UINib.init(nibName: K.Cells.calendarNib, bundle: nil)
        self.tableView.register(calenderCellNib, forCellReuseIdentifier: K.Cells.calendarReusableCell)
        
        let timeOfDayCellNib = UINib.init(nibName: K.Cells.timeOfDayNib, bundle: nil)
        self.tableView.register(timeOfDayCellNib, forCellReuseIdentifier: K.Cells.timeOfDayReusableCell)
        
        let addMedCellNib = UINib.init(nibName: K.Cells.addMedNib, bundle: nil)
        self.tableView.register(addMedCellNib, forCellReuseIdentifier: K.Cells.addMedCell)
        
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            listBrain.deleteMedication(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
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
    
    //MARK: - Data Manipulation
    
    func loadList() {
        listBrain.loadMedications()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // Function that deletes a medication based on its index path
    
    
    //MARK: - Scroll Methods
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        timeLabel.moveAndResizeLabel(for: height)
    }
}

//MARK: - Add Button Delegate

extension ScheduleTableViewController: AddMedsDelegate {
    func addMedTapped(at index: IndexPath) {
        performSegue(withIdentifier: K.Segue.addMedSegue, sender: self)
    }
    
}


//MARK: - ListBrain Delegate

extension ScheduleTableViewController: ListBrainDelegate {
    
    func didLoadList(_ listBrain: ListBrain) {
        tableView.reloadData()
    }
}
