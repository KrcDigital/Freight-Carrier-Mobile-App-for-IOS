//
//  create_step_4.swift
//  CamelPro
//
//  Created by Can Kirac on 30.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class create_step_4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
        // Initialization code
        print("buradadeger2\(self.yerboylamk)")

        
    }
  
    var lastset = ""
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBOutlet weak var kilo: UITextField!
    var kalkis_yeri = ""
    var varis_yeri = ""
    var detay = ""
    var ucret = ""
    @IBOutlet weak var datee: UIDatePicker!
    
    @IBAction func geri(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    var yerenlemv = Double()
    var yerboylamv = Double()
    var yerenlemk = Double()
    var yerboylamk = Double()
    var araccesit = ""
    
    @IBAction func create(_ sender: UIButton) {
        if nebe == 1 {
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                tarihstr = dateFormatter.string(from: datee.date)
        }
        else {
            tarihstr = "1-3 Gün İçinde"
        }
            
        print("burasi \(Auth.auth().currentUser!.displayName!)")
        print("burasi2 \(Auth.auth().currentUser!.displayName! as! String)")

                            let firestore = Firestore.firestore()
        let firestorepacket = ["isveren_img":Auth.auth().currentUser?.photoURL?.absoluteString,"isveren":Auth.auth().currentUser!.displayName!,"kalkis_yeri":self.kalkis_yeri,"varis_yeri":self.varis_yeri,"detay":self.detay,"ucret":self.ucret,"date":Date.now,"isveren_id":Auth.auth().currentUser?.uid,"gosterim":0,"tarih":self.tarihstr,"kilo":kilo.text,"confirm":0,"telefon":Auth.auth().currentUser?.phoneNumber!,"durum":"0","araccesit":self.araccesit,"varisen":self.yerenlemv,"varisboy":self.yerboylamv,"kalkisen":self.yerenlemk,"kalkisboy":self.yerboylamk] as [String : Any]
                            
                            var firestoreref : DocumentReference?
                            firestoreref = firestore.collection("icerikler").addDocument(data: firestorepacket, completion: { error in
                                if error != nil {
                                    print("hata aldın")
                                }
                                else {
                                    self.showAlertButtonTapped()

                                    
                                    
                                }
                            })
                        }
    
    var tarihstr = ""
    var nebe = 0
    @IBAction func add_segment_change(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0:
            tarihstr = "13"
            datee.isHidden = true
            nebe = 0
            case 1:
            nebe = 1
            datee.isHidden = false

            

        default:
            nebe = 0
            tarihstr = "13"
            datee.isHidden = true
            
        }
        
    }
    
    @objc func showAlertButtonTapped() {

           

        let alert = UIAlertController(title: "Başarılı", message: "İlan başarılı bir şekilde oluşturuldu. Nakliyeciler başvuru yapabilir", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
            switch action.style{
                case .default:
                
                self.performSegue(withIdentifier: "geri", sender: nil)
                
            case .cancel:
                self.performSegue(withIdentifier: "geri", sender: nil)

            case .destructive:
                self.performSegue(withIdentifier: "geri", sender: nil)

            @unknown default:
                self.performSegue(withIdentifier: "geri", sender: nil)

            }
        }))
        self.present(alert, animated: true, completion: nil)
        }

    
    
    
    
}
