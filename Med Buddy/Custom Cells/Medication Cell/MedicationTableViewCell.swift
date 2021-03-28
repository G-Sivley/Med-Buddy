//
//  MedicationTableViewCell.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/25/21.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var medicationNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let radius = cellView.frame.height / 4
        cellView.layer.cornerRadius = radius
        
        cellView.layer.masksToBounds = false
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.2
        cellView.layer.shadowOffset = CGSize(width: -6, height: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
