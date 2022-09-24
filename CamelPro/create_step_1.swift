//
//  create_step_1.swift
//  CamelPro
//
//  Created by Can Kirac on 20.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
    
    
    
class create_step_1: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sehirler.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getsehirler()
        // Do any additional setup after loading the view.
    }
    
    var isveren_id = ""

    var selected_kalkis = ""
    
    var selected_varis = ""
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sehirler[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_sehir = sehirler[row]
    }
    var selected_sehir = "Adana"
    
    var sehirler = [String]()
    
    
    func getsehirler() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("sehirler").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.sehirler.removeAll()
                    
                    
                    for doc in  snapshot!.documents {
                        
                            let docId = doc.documentID
                            if let sehir = doc.get("sehir") as? String {
                                
                                self.sehirler.append(sehir)
                            }
 
                        
                    }

                }
            }
            self.kalkispicker.dataSource = self
            self.kalkispicker.delegate = self
            
            
        
        }
    }
    @IBOutlet weak var kalkispicker: UIPickerView!
    
    @IBAction func nextstep(_ sender: Any) {
        performSegue(withIdentifier: "nextstep", sender: nil)
    }
    
    var namee = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextstep" {

        let destinationvc = segue.destination as! maps_page
        destinationvc.isveren_id = isveren_id
        destinationvc.namee = namee
        destinationvc.selected_kalkis = selected_sehir
            
        }
        
    }
    
    @IBAction func geri(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
}
