//
//  TimeOfDayCell.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/28/21.
//

import UIKit

protocol TimeOfDayAddDelegate {
    func addTimeOfDayTapped(at index: IndexPath)
}

class TimeOfDayCell: UITableViewCell {


    @IBOutlet weak var timeLabel: UILabel!
    
    var indexPath: IndexPath!
    var delegate: TimeOfDayAddDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addButtonPressed(_ sender: UIButton) {
        self.delegate?.addTimeOfDayTapped(at: indexPath)
    }
    
}
