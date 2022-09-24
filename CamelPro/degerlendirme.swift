//
//  degerlendirme.swift
//  CamelPro
//
//  Created by Can Kirac on 12.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class degerlendirme: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func add_segment_change(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0:
            
            self.puanim = "1"

            case 1:
            self.puanim = "2"
        case 2:
        
        self.puanim = "3"

        case 3:
        self.puanim = "4"
        case 4:
        
        self.puanim = "5"

        
            

        default:
            self.puanim = "1"

            
                   }
        
    }
    var puanim = "1"
    var user_id = ""
    @IBOutlet weak var yorumum: UITextView!
    @objc func send_msj() {


                                
                let firestore = Firestore.firestore()
        let firestorepacket = ["sahip":self.user_id,"yorum":yorumum.text ,"paun":self.puanim] as [String : Any]
                                
                                var firestoreref : DocumentReference?
                                firestoreref = firestore.collection("degerlendirme").addDocument(data: firestorepacket, completion: { error in
                                    if error != nil {
                                        print("hata aldın")
                                    }
                                    else {
                                        self.navigationController?.popViewController(animated: true)

                                        self.dismiss(animated: true, completion: nil)

                                    }
                                })
            
        }
            
    @IBAction func tamam(_ sender: Any) {
        send_msj()
    }
    
    @IBAction func geri(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
}
