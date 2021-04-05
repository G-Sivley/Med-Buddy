//
//  AddViewController.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/21/21.
//

import UIKit

class AddViewController: UIViewController, UINavigationControllerDelegate{

    @IBOutlet weak var medImage: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var settingTableView: UITableView!
    
    let imagepicker = UIImagePickerController()
    var imagePresent = ImagePresent.needImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let medSettingNib = UINib.init(nibName: K.Cells.medSettingNib, bundle: nil)
        settingTableView.register(medSettingNib, forCellReuseIdentifier: K.Cells.medSettingCell)

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
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagepicker.delegate = self;
            imagepicker.modalTransitionStyle = .flipHorizontal
            imagepicker.allowsEditing = true
            imagepicker.sourceType = .camera
            imagepicker.mediaTypes = ["public.image"]
            imagepicker.cameraCaptureMode = .photo
            imagepicker.cameraDevice = .rear
            self.present(imagepicker, animated: true) { () -> Void in
            }
            
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        // Save Info
        
        dismiss(animated: true, completion: nil)
        print("saved")
    }
    
    //MARK: - UI Setup
    
    func makeImageCircular() {
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 2
        medImage.layer.cornerRadius = medImage.frame.height / 2
    }
}

extension AddViewController: UIImagePickerControllerDelegate {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        medImage.image = image
        imagepicker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Table Data

extension AddViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settings: [(title: String, detail: String)] = [("Dose", "20 mg"), ("Frequency", "Twice Daily"), ("Time and Dose", "X 1"), ("Indication", "Depression")]
        let cell = settingTableView.dequeueReusableCell(withIdentifier: K.Cells.medSettingCell) as! MedSettingTableViewCell
        
        cell.titleLabel.text = settings[indexPath.row].title
        cell.accessoryLabel.text = settings[indexPath.row].detail
        
        return cell
    }
}
