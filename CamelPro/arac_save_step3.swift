//
//  arac_save_step3.swift
//  CamelPro
//
//  Created by Can Kirac on 21.05.2022.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class arac_save_step3: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return araccesit.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return araccesit[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tur = araccesit[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        aracpicker.dataSource = self
        aracpicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var aracpicker: UIPickerView!
    
    
    
    var araccesit = ["Tenteli Tır(13,60)","Treyler Tır","Açık Tır(13,60)","Lowbed Tır","Frigo Tır","Tanker Tır","Havuz Tipi Damperli Tır","Sal Kasa Tır","Flat Rack Tır","Kısa Dorse Tır","Kapalı Kasa Tır","Kırkayak","Frigo Kamyon","Havuz Damperli Kamyon","Açık Kasa Kamyon","Açık Kasa Damperli Kamyon","Brandalı Kamyon","Kurtarıcı Kamyon","Flat Rack Kamyon"]
    
  


    var plaka = ""
    var imgurl = ""
    var tur = ""
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var Marka: UITextField!
    
    @IBOutlet weak var kayitlast: UIView!
    
    @IBOutlet weak var viewtwo: UIView!
    
    @IBAction func create(_ sender: UIButton) {
        
        
        

        
           
                            
                            let firestore = Firestore.firestore()
        let firestorepacket = ["plaka":plaka,"img":imgurl,"sahip":Auth.auth().currentUser?.uid,"model":model.text,"marka":Marka.text,"tur":tur,"durum":0] as [String : Any]
                            
                            var firestoreref : DocumentReference?
                            firestoreref = firestore.collection("araclar").addDocument(data: firestorepacket, completion: { error in
                                if error != nil {
                                    print("hata aldın")
                                }
                                else {
                                    
                                    let alert = UIAlertController(title: "Başarılı", message: "Araç ekleme işlemi başarı ile gerçekleşti.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
                                        switch action.style{
                                            case .default:
                                            self.performSegue(withIdentifier: "geri", sender: nil)


                                            print("i")
                                            
                                        case .cancel:
                                            self.performSegue(withIdentifier: "geri", sender: nil)


                                            print("i")

                                        case .destructive:
                                            self.performSegue(withIdentifier: "geri", sender: nil)


                                            print("i")

                                        @unknown default:
                                            print("i")

                                        }
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                            })
                        }
                
            
       

}
