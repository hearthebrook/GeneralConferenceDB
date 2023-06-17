//
//  ViewController.swift
//  genConf
//
//  Created by Brooklynn Hathaway on 6/14/23.
//

import UIKit
import Firebase
import SwiftUI
import Combine

class ViewController: UIViewController {
    
    let ref = Database.database().reference(withPath: "apostles")
    let apostlesCollection = Firestore.firestore().collection("apostles")
    
    func displayInfo(apostleInfoDict:NSDictionary){
        print("\(apostleInfoDict["name"]!) - \(apostleInfoDict["ordinationDate"]!)")
        
    }
    
    struct Apostle {
        var name: String
        var birthDate: String
        var ordinationDate: String
        var position: String
        var biography: String
        
        init?(with dictionary: NSDictionary) {
            guard let name = dictionary["name"] as? String,
                let birthDate = dictionary["birthDate"] as? String else {
                    return nil
            }
            
            self.name = name
            self.birthDate = birthDate
            self.ordinationDate = dictionary["ordinationDate"] as? String ?? ""
            self.position = dictionary["position"] as? String ?? ""
            self.biography = dictionary["biography"] as? String ?? ""
        }
        
        func displayApostle() {
            print(name)
            print(biography)
        }
    }
    
    struct ApostleCard: View {
        var apostle: Apostle
        
        var body: some View{
            VStack {
                Text(apostle.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text(apostle.biography)
                    .font(.body)
                    .padding()
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius:5)
            .padding()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let apostles = ref.child("apostles")
        
        apostles.observeSingleEvent(of: .value, with: { snapshot in
            // This is the snapshot of the data at the moment in the Firebase database
            var apostleCards: [ApostleCard] = []
            
            // Loops through all of the children of the apostles snapshot (every apostle in the database)
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                // Takes the aposlte and maps it to a dictionary where each value can be individually used
                        if let infoDict = child.value as? NSDictionary {
                            if let newApostle = Apostle(with: infoDict) {
                                //print(newApostle)
                                apostleCards.append(ApostleCard(apostle: newApostle))
                            }
                        }
                    }
            // Now I have an array of ApostleCards to use
            for apostleCard in apostleCards {
                print(apostleCard.apostle.name)
            }
        })
        
        // ADD a new apostle to the Database (for example if someone dies...)
        let apostleData: [String: Any] = [
            "name": "John Doe",
            "birthdate": "1990-01-01",
            "ordinationDate": "2022-02-15",
            "position": "Apostle",
            "biography": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        ]
        
        apostlesCollection.addDocument(data: apostleData) { error in
            if let error = error {
                // Error occurred while adding the apostle
                print("Error adding apostle: \(error.localizedDescription)")
            } else {
                // Apostle added successfully
                print("Apostle added successfully")
            }
        }
        
        // UPDATE that apostles info if they entered it wrong
        let documentID = apostlesCollection.document("apostle").documentID
        let apostleRef = Firestore.firestore().collection("apostles").document(documentID)

        let updatedData: [String: Any] = [
            "name": "Jon"
        ]

        apostleRef.updateData(updatedData) { error in
            if let error = error {
                print("Error updating apostle: \(error.localizedDescription)")
            } else {
                print("Apostle updated successfully")
            }
        }
        
        // DELETE the record
        apostleRef.delete { error in
            if let error = error {
                // Error occurred while deleting the apostle
                print("Error deleting apostle: \(error.localizedDescription)")
            } else {
                // Apostle deleted successfully
                print("Apostle deleted successfully")
            }
        }

    } // ViewDidLoad closing bracket
}


/*
 struct Apostle{
     var name: String
     var birthDate: String
     var ordinationDate: String
     var position: String
     var biography: String
     
     init(name: String, birthDate: String, ordinationDate: String, position: String, biography: String) throws{
         self.name = try ref.value(for:"name")
         self.name = name
         self.birthDate = birthDate
         self.ordinationDate = ordinationDate
         self.position = position
         self.biography = biography
     }
 }
 
 ========================================
 
 struct Apostle: Codable{
     @DocumentID var id: String?
     var name: String
     var birthDate: String
     var ordinationDate: String
     var position: String
     var biography: String
 }
 
 private func fetchApostle(documentId: String){
     let ref = Database.database().reference(withPath: "apostles")
     //let docRef = db.collection("apostle").document(documentId)
     
     ref.getDocument(as: Apostle.self){result in
         switch result {
         case .success(let apostle):
             self.apostle = apostle
             self.errorMessage = nil
         case .failure(let error):
             self.errorMessage = "Error decoding document: \(error.localizedDescription)"
         }
     }
 }
 
 ============================================
 
 apostles.observeSingleEvent(of: .value, with: { snapshot in
     // This is the snapshot of the data at the moment in the Firebase database
     // To get value from the snapshot, we user snapshot.value
     for child in snapshot.children.allObjects as! [DataSnapshot]{
         let reward = Reward.parseJson(JSON(child.value ?? []))
         self.rewardList.append(reward)
     }
     print(snapshot.value as Any)
     
 })
 
 =============================================
 
 nelsonRef.child("name").observeSingleEvent(of: .value, with: { snapshot in
     // This is the snapshot of the data at the moment in the Firebase database
     // To get value from the snapshot, we user snapshot.value
     if let info = snapshot.value as? String{
         print(info)
     }
     //print(snapshot.value as Any)
     print("It made it here")
     
 })
 
 
 =================================================
 for child in snapshot.children.allObjects as! [DataSnapshot] {
     // Takes the aposlte and maps it to a dictionary where each value can be individually used
 
     child.value.map{ if let infoDict = $0 as? NSDictionary {
         //self.displayInfo(apostleInfoDict: infoDict)
         let newApostle = Apostle(with: infoDict)
         print(newApostle)
     }}
 }
 
 */
