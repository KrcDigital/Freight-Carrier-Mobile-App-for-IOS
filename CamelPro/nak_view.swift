//
//  nak_view.swift
//  CamelPro
//
//  Created by Can Kirac on 16.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage




class nak_view: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        getbasvurular()
        getdetay()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var varis: UILabel!
    
    @IBOutlet weak var basvuranlar: UIButton!
    @IBOutlet weak var kalkis: UILabel!
    var is_id = ""
    @IBOutlet weak var ucret: UILabel!
    @IBOutlet weak var kisi: UILabel!
    @IBOutlet weak var tasinma: UILabel!
    @IBOutlet weak var detay: UITextView!
    @IBAction func geri(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
    var sayacbasvuru = 0
    
    func getbasvurular() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerik_basvuru").whereField("icerik", isEqualTo:  self.is_id).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.sayacbasvuru = 0
                    
                    
                    for doc in  snapshot!.documents {
                        
                            let docId = doc.documentID
                        if let id = doc.get("icerik"){
                                
                            self.sayacbasvuru = self.sayacbasvuru + 1
                            }
 
                        
                    }

                }
            }
            
            self.basvuranlar.setTitle("Başvuranlar (\(self.sayacbasvuru))", for: .normal)

            
        
        }
    }
    @IBOutlet weak var araclbl: UILabel!
    
    func getdetay() {
        
        
        
        
        
        
        
        let firestoredb = Firestore.firestore()
        
        
        
        let docRef = firestoredb.collection("icerikler").document(self.is_id)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                
                var num = Int(document.get("ucret") as! String)!.formattedWithSeparator
                        
                    self.detay.text = document.get("detay") as! String
                    self.kisi.text = "\(document.get("gosterim") as! Int) Kişi İnceledi"
                self.ucret.text = "Ücret: \(num) TL"
                self.araclbl.text = "Araç : \(document.get("araccesit") as! String)"
                    self.kalkis.text = document.get("kalkis_yeri") as! String
                    self.varis.text = document.get("varis_yeri") as! String
                    self.tasinma.text = "Taşınma Tarihi: \( document.get("tarih") as! String)"
                
                
            } else {
                print("Document does not exist")
            }
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "start" {
            let destiantionVC = segue.destination as! ilan_basvurularim
            
            destiantionVC.icerik_id = is_id
            
            
    }
    }
    
   @objc func tobek(_ sender: Any) {
        
        performSegue(withIdentifier: "start", sender: nil)
        
    }
    
    @objc func silme ()
        {
            
            
            
            let db = Firestore.firestore()
            db.collection("icerikler").document(self.is_id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    self.navigationController?.popViewController(animated: true)

                    self.dismiss(animated: true, completion: nil)
                }
        }
        }
    
    @IBAction func silmebtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "Onay", message: "İlanı silmeyi onaylıyor musunuz ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { action in
            switch action.style{
                case .default:
                self.silme()
                
                print("i")
                
            case .cancel:

                print("i")

            case .destructive:

                print("i")

            @unknown default:
                print("i")

            }
        }))
        alert.addAction(UIAlertAction(title: "Hayır", style: .cancel))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
