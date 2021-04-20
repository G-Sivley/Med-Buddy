//
//  addMedButtonTableViewCell.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/31/21.
//

import UIKit

protocol AddMedsDelegate{
    func addMedTapped(at index: IndexPath)
}

class AddMedButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addMedButton: UIButton!
    
    var indexPath: IndexPath!
    var delegate: AddMedsDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //addMedButton.layer.cornerRadius = addMedButton.frame.height / 2
        addMedButton.layer.cornerRadius = 40 / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        self.delegate?.addMedTapped(at: indexPath)
    }
}
