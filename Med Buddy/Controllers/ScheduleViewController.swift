//
//  ScheduleViewController.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/21/21.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate {
    
    
    
    @IBOutlet weak var medicationTableView: UITableView!
    
    let medicationsArray = ["Fluoxetine", "Prasugrel", "Ibuprofen"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        
        
        // Register and setup medication table
        let nib = UINib.init(nibName: K.medicationNib, bundle: nil)
        self.medicationTableView.register(nib, forCellReuseIdentifier: K.medicationReusableCell)
        
        
       
        
        // Setup NavBar
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

//MARK: - TableView Setup

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.medicationReusableCell, for: indexPath) as! MedicationTableViewCell
        
        return cell
    }
}
