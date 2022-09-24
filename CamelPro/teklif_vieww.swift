//
//  teklif_vieww.swift
//  CamelPro
//
//  Created by Can Kirac on 16.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class teklif_vieww: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        geticerik()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var kalkis: UILabel!
    
    @IBOutlet weak var varis: UILabel!
    
    @IBOutlet weak var isveren: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var detay: UITextView!
    
    @IBAction func iptal(_ sender: Any) {
        
        let alert = UIAlertController(title: "Onay", message: "Teklif iptalini onaylıyor musunuz?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { action in
            switch action.style{
                case .default:
                
                let db = Firestore.firestore()
                db.collection("icerik_basvuru").document(self.realid).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        self.navigationController?.popViewController(animated: true)

                        self.dismiss(animated: true, completion: nil)
                    }
            }
                
            case .cancel:
                print("i")

            case .destructive:
                print("i")

            @unknown default:
                print("i")

            }
        }))
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.cancel))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func aramayap(_ sender: Any) {
        
        guard let number = URL(string: "tel://08508888280") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    var realid = ""
    var icerikid = ""
    var latik = Double()
    var longgk = Double()
    func geticerik() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerikler").document(icerikid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                
                    
                    
                
                self.kalkis.text = snapshot?.get("kalkis_yeri") as! String
                self.varis.text = snapshot?.get("varis_yeri") as! String
                self.detay.text = snapshot?.get("detay") as! String
                self.logo.sd_setImage(with: URL(string:snapshot?.get("isveren_img") as! String ))
                self.isveren.text = snapshot?.get("isveren") as! String

                self.latik = snapshot?.get("kalkisboy") as! Double
                
                self.longgk = snapshot?.get("kalkisen") as! Double
               

                }
            
            
            }
           

            
        
        }
    
    @IBAction func geri(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func daddaya(_ sender: Any) {
        performSegue(withIdentifier: "harit", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "harit" {
        
        let dest = segue.destination as! is_haritam
        dest.long = longgk
        dest.lati = latik
    }
        
    }
    
}
