//
//  basvuru.swift
//  CamelPro
//
//  Created by Can Kirac on 26.05.2022.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseFirestore
import OneSignal

class basvuru: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getuid()
        plaka.text = plakano
        imgs.sd_setImage(with: URL(string: imgurl))

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
        getusernumber()
        // Initialization code
    }
  
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func geri(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet weak var plaka: UILabel!
    
    var plakano = ""
    var imgurl = ""
    var arabaid = ""
    var jetonum = 0
    var icerik_id = ""
    @IBOutlet weak var basvurumtn: UITextView!
    
    @IBOutlet weak var imgs: UIImageView!
    
    @IBAction func create(_ sender: UIButton) {
        
      
                            let firestore = Firestore.firestore()
        let firestorepacket = ["icerik":icerik_id,"arabaid":arabaid,"nakliyeci":Auth.auth().currentUser?.uid,"basvuru_msj":basvurumtn.text,"fiyat":fiyattext.text] as [String : Any]
                            
                            var firestoreref : DocumentReference?
                            firestoreref = firestore.collection("icerik_basvuru").addDocument(data: firestorepacket, completion: { error in
                                if error != nil {
                                }
                                else {
                                    
                                    self.gncl()
                                    self.showAlertButtonTapped()
                                    
                                }
                            })
                        }
           
    
    var docuser = ""
    
    @objc func getuid() {
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("user_id", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.docuser = doc.documentID as! String
                          
                        }
                      
                    }

                }
                               
            }
            
            
       }
    }
    
    @objc func gncl() {
        let firestoredb = Firestore.firestore()
        let newnote = ["jeton":jetonum - 1] as [String : Any]
        firestoredb.collection("users").document(docuser).setData(newnote, merge: true)
        
    }
    @IBOutlet weak var fiyattext: UITextField!
    @objc func showAlertButtonTapped() {

           

        let alert = UIAlertController(title: "Başvuru", message: "Başvurunuzu iş verene iletildi.Teklifinizin onaylanma durumunda şirket bilgileri tarafınıza iletilecek", preferredStyle: .alert)
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
    
    @objc func sendonesig() {
        
        OneSignal.postNotification(["contents": ["tr": "İşiniz için yeni başvuru yapıldı. "], "include_player_ids":["\(self.nakliyecisignal)"]])
        
    }

    
    var nakliyecisignal = ""
    
    @objc func onekayit() {
        
        
        let dbase = Firestore.firestore()

            
        dbase.collection("PlayerId").whereField("numara", isEqualTo: self.isverenone).getDocuments { snapshot, error in
                if error != nil {
                    if snapshot?.isEmpty == false && snapshot != nil {
                        for document in snapshot!.documents {
                            if let playimid = document.get("signalid") as? String {
                                
                                
                                self.nakliyecisignal = (document.get("signalid") as? String)!
                                
                                
                            }
                        }
                    }
                    
                }
            }
            
        
        }
    
    var isverenone = ""
    
    @objc func getusernumber() {
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerikler").document(icerik_id).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                    
                   
                            
                            self.isverenone = snapshot!.get("telefon") as! String
                          
                        
                      
                    

                
                               
            }
            self.onekayit()

            
            
       }
    }
    
    
}
