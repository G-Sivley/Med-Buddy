//
//  ListBrain.swift
//  Med Buddy
//
//  Created by Grant Sivley on 5/4/21.
//

import Firebase
import Foundation

protocol ListBrainDelegate {
    func didLoadList(_ listBrain: ListBrain)
}


class ListBrain {
    
    var delegate: ListBrainDelegate?
    
    private let db = Firestore.firestore()
    var docRef = Firestore.firestore().collection("medications")
    var medicationList: [Medication] = []
    
    
    //MARK: - CRUD Methods
    
    func loadMedications() {
        
        db.collection("medications").order(by: "name").addSnapshotListener { (querySnapshot, error) in
            self.medicationList = []
            
            // Error loading
            // Need to make better error handling
            if let e = error {
                print("There was an error retrieving data: \(e)")
            } else {
                // Correctly loaded
                if let snapshotDocuments = querySnapshot?.documents {
                    
                    // Create variable for checking when the last document is
                    var count = 0
                    
                    for doc in snapshotDocuments {
                        count += 1
                        let data = doc.data()
                        if let medName = data["name"] as? String {
                            
                            // Possible imgID
                            let imgID = data["imgID"] as? String
                            
                            // Closure to add the image after medicationImg has been retreived
                            self.retrieveImg(imgID: imgID) { (medicationImg) in
                                let medication = Medication(name: medName, id: doc.documentID, img: medicationImg, imgID: imgID)
                                self.medicationList.append(medication)
                                
                                
                                // This fires every time it is loaded
                                // I would like this to only fire once completed
                                self.delegate?.didLoadList(self)
                                print("firing")
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    func addMedication(name medName: String, imgID: String?) {
        let dataToSave: [String: Any] = ["name": medName, "unit": "mg", "dose": 20, "imgID": imgID as Any]
        docRef.addDocument(data: dataToSave) { (error) in
            if let error = error {
                print("Error saving medication \(error.localizedDescription)")
            } else {
                print("Data has been saved")
                self.loadMedications()
            }
        }
    }
    
    
    func deleteMedication(indexPath: IndexPath) {
        db.collection("medications").document(medicationList[indexPath.row - 3].id).delete { (error) in
            if let e = error {
                print("Error removing document: \(e)")
            } else {
                print("Document was successfully removed.")
            }
        }
        self.medicationList.remove(at: indexPath.row - 3)
    }
    
    //MARK: - Image Methods
    
    func retrieveImg(imgID: String?, completionHandler: @escaping (UIImage) -> Void) {
        if let id = imgID {
            
            // Create closure that retreives Img from Storage
            let storageRef = Storage.storage().reference(withPath: "medications/\(id).jpg")
            
            storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
                if let e = error {
                    print("Got an error fetching data: \(e.localizedDescription)")
                    completionHandler(UIImage(systemName: "pills.fill")!)
                    
                } else {
                    if let data = data {
                        if let imgFromData = UIImage(data: data) {
                            completionHandler(imgFromData)
                        }
                    }
                }
            }
        }
        
        else {
            completionHandler(UIImage(systemName: "pills.fill")!)
        }
    }
    
    func uploadImage(imageData: Data, randomID: String) {
        
        let uploadRef = Storage.storage().reference(withPath: "medications/\(randomID).jpg")
        
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        
        uploadRef.putData(imageData, metadata: uploadMetadata) { (downloadMetadata, error) in
            if let e = error {
                print("Error uploading image to storage: \(e.localizedDescription)")
            } else {
                print("Image upload complete and I got this back: \(String(describing: downloadMetadata))")
            }
        }
    }
    
    func makeImgID() -> String {
        // Create a random ID for path initialization
        let randomID = UUID.init().uuidString
        return randomID
    }
}
