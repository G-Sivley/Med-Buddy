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
    var medicationList: [Medication] = []
    
    func loadMedications() {
        
        db.collection("medications").order(by: "name").addSnapshotListener { (querySnapshot, error) in
            self.medicationList = []
            
            if let e = error {
                print("There was an error retrieving data: \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let medName = data["name"] as? String {
                            
                            // Need to fix this later. This could be dangerous
                            
                            let medication = Medication(name: medName, id: doc.documentID)
                            self.medicationList.append(medication)
                            
                            DispatchQueue.main.async {
                                self.delegate?.didLoadList(self)
                            }
                        }
                    }
                }
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
}
