//
//  Medication.swift
//  Med Buddy
//
//  Created by Grant Sivley on 4/28/21.
//

import UIKit


struct Medication {
    var name: String
    var dose: Int = 20
    var unit: String = "mg"
    var id: String
    
    var img: UIImage?
    var imgID: String?
}
