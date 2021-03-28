//
//  TimeOfDayCell.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/28/21.
//

import UIKit

class TimeOfDayCell: UITableViewCell {


    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addButtonPressed(_ sender: UIButton) {

    }
    
}
