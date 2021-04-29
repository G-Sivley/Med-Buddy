//
//  AddViewController.swift
//  Med Buddy
//
//  Created by Grant Sivley on 3/21/21.
//

import UIKit
import Firebase

class AddViewController: UIViewController, UINavigationControllerDelegate{

    @IBOutlet weak var medImage: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var medNameTextBox: UITextField!
    
    let imagePicker = UIImagePickerController()
    var imagePresent = ImagePresent.needImage
    
    var settingsArray: [(title: String, detail: String)] = [("Dose", "20 mg"), ("Frequency", "Twice Daily"), ("Time and Dose", "X 1"), ("Indication", "Depression")]
    
    var docRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let medSettingNib = UINib.init(nibName: K.Cells.medSettingNib, bundle: nil)
        settingTableView.register(medSettingNib, forCellReuseIdentifier: K.Cells.medSettingCell)

        // Do any additional setup after loading the view.
        makeImageCircular()
        addShadow(view: imageContainerView, opacity: 0.4, offset: CGSize(width: -4, height: 4), radius: 4)
        
        settingTableView.delegate = self
        
        docRef = Firestore.firestore().collection("medications")
        
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
    
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            if segue.identifier == K.Segue.showSettings {
                if let destinationVC = segue.destination as? SettingViewController {
                    if let indexPath = self.settingTableView.indexPathForSelectedRow {
                        destinationVC.settingTitle = settingsArray[indexPath.row].title
                        
                    }
                }
                
            }
        }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: K.Segue.showSettings, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
  
    //MARK: - Button Pressed Methods
    
    @IBAction func addImagePressed(_ sender: UIButton) {
        imagePresent = ImagePresent.haveImage
        applyImageAppearance()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.delegate = self;
            imagePicker.modalTransitionStyle = .flipHorizontal
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.cameraCaptureMode = .photo
            imagePicker.cameraDevice = .rear
            self.present(imagePicker, animated: true) { () -> Void in
            }
            
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        // Save Info
        
        if let medName = medNameTextBox.text?.capitalized {
            
            guard let image = medImage.image else {
                
                print("No image")
                return
            }
            uploadImage()
            
            let dataToSave: [String: Any] = ["name": medName, "unit": "mg", "dose": 20]
            docRef.addDocument(data: dataToSave) { (error) in
                if let error = error {
                    print("Error saving medication \(error.localizedDescription)")
                } else {
                    print("Data has been saved")
                }
            }
        }

       
        
        dismiss(animated: true, completion: nil)
        print("saved")
    }
    
    
    func uploadImage() {
        
        // Create a random ID for path initialization
        let randomID = UUID.init().uuidString

        let uploadRef = Storage.storage().reference(withPath: "medications/\(randomID).jpg")
        
        guard let imageData = medImage.image?.jpegData(compressionQuality: 0.75) else {return}
        
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        
        uploadRef.putData(imageData, metadata: uploadMetadata) { (downloadMetadata, error) in
            if let e = error {
                print("Error uploading image to storage: \(e.localizedDescription)")
            } else {
                print("Image upload complete and I got this back: \(downloadMetadata)")
            }
        }
        
        
    }
    
    //MARK: - UI Setup
    
    func makeImageCircular() {
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 2
        medImage.layer.cornerRadius = medImage.frame.height / 2
    }
}

//MARK: - Image Picker Delegate

extension AddViewController: UIImagePickerControllerDelegate {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        medImage.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Table Data

extension AddViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = settingTableView.dequeueReusableCell(withIdentifier: K.Cells.medSettingCell) as! MedSettingTableViewCell
        
        cell.titleLabel.text = settingsArray[indexPath.row].title
        cell.accessoryLabel.text = settingsArray[indexPath.row].detail
        
        return cell
    }
    
}
