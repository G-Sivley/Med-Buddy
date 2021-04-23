//
//  MedSettingTableViewCell.swift
//  Med Buddy
//
//  Created by Grant Sivley on 4/5/21.
//

import UIKit

class MedSettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var accessoryLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(named: K.Colors.drugWhite)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
