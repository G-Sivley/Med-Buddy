//
//  AddViewController.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/21/21.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var medImage: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    
    var imagePresent = ImagePresent.needImage
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        makeImageCircular()
        addShadow(view: imageContainerView, opacity: 0.4, offset: CGSize(width: -4, height: 4), radius: 4)
    }
    

    enum ImagePresent {
        case needImage
        case haveImage
    }
    
    func applyImageAppearance() {
        switch imagePresent {
        case .needImage:
            imageLabel.alpha = 1
        case .haveImage:
            imageLabel.alpha = 0
        }
    }
    
    
    
    // MARK: - Navigation
    
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        // Get the new view controller using segue.destination.
    //        // Pass the selected object to the new view controller.
    //    }
    

    //MARK: - Button Pressed Methods
    
    @IBAction func addImagePressed(_ sender: UIButton) {
        imagePresent = ImagePresent.haveImage
        applyImageAppearance()
    }
    
    
    //MARK: - UI Setup
    
    func makeImageCircular() {
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 2
        medImage.layer.cornerRadius = medImage.frame.height / 2
    }
}
