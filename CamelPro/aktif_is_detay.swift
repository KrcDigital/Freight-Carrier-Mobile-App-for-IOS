//
//  aktif_is_detay.swift
//  CamelPro
//
//  Created by Can Kirac on 6.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SDWebImage
class aktif_is_detay: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        geticerik()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBOutlet weak var detaylbl: UITextView!
    @IBOutlet weak var kalkislbl: UILabel!
    
    @IBOutlet weak var isveren: UILabel!
    @IBOutlet weak var isverenimg: UIImageView!
    @IBOutlet weak var varislbl: UILabel!
    var icerikid = ""
 var realid = ""
    @IBAction func geri(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
    var latik = Double()
    var longgk = Double()
    var lativ = Double()
    var longgv = Double()
    func geticerik() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerikler").document(icerikid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                
                    
                    
                
                self.kalkislbl.text = snapshot?.get("kalkis_yeri") as! String
                self.varislbl.text = snapshot?.get("varis_yeri") as! String
                self.detaylbl.text = snapshot?.get("detay") as! String
                self.isverenimg.sd_setImage(with: URL(string:snapshot?.get("isveren_img") as! String ))
                self.isveren.text = snapshot?.get("isveren") as! String

                self.latik = snapshot?.get("kalkisboy") as! Double
                
                self.longgk = snapshot?.get("kalkisen") as! Double
                self.lativ = snapshot?.get("varisboy") as! Double
                
                self.longgv = snapshot?.get("varisen") as! Double

                }
            
            
            }
           

            
        
        }
    
    @IBAction func bitir(_ sender: Any) {
        
        
        showAlertButtonTapped()
        
        
     
        
         
        
    }
    var ne = 0
    @IBAction func vari(_ sender: Any) {
        ne = 1
        performSegue(withIdentifier: "haritam", sender: nil)
    }
    @IBAction func kali(_ sender: Any) {
        ne = 0
        performSegue(withIdentifier: "haritam", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "haritam" {
            let destinationVC = segue.destination as! is_haritam
            if ne == 0 {
                destinationVC.lati = latik
                destinationVC.long = longgk
                destinationVC.titlem = "Kalkış Yeri"
            }
            if ne == 1 {
                destinationVC.lati = lativ
                destinationVC.long = longgv
                destinationVC.titlem = "Varış Yeri"

            }
            
        }
       
        
    }
    
    
    @IBAction func aramayap(_ sender: Any) {
        
        guard let number = URL(string: "tel://08508888280") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    @objc func showAlertButtonTapped() {

           

        let alert = UIAlertController(title: "Onay", message: "İşi bitirmeyi onaylıyor musunuz ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { action in
            switch action.style{
                case .default:
                
                let date = Date()
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = df.string(from: date)
                
                let firestoredb = Firestore.firestore()
                let newnote = ["durum":"2","bitme_tarihi":dateString] as [String : Any]
                firestoredb.collection("islerim").document(self.realid).setData(newnote, merge: true)
                
                self.navigationController?.popViewController(animated: true)

                self.dismiss(animated: true, completion: nil)
                
            case .cancel:
                let date = Date()
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = df.string(from: date)
                
                let firestoredb = Firestore.firestore()
                let newnote = ["durum":"2","bitme_tarihi":dateString] as [String : Any]
                firestoredb.collection("islerim").document(self.realid).setData(newnote, merge: true)
                
                self.navigationController?.popViewController(animated: true)

                self.dismiss(animated: true, completion: nil)

            case .destructive:
                let date = Date()
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = df.string(from: date)
                
                let firestoredb = Firestore.firestore()
                let newnote = ["durum":"2","bitme_tarihi":dateString] as [String : Any]
                firestoredb.collection("islerim").document(self.realid).setData(newnote, merge: true)
                
                self.navigationController?.popViewController(animated: true)

                self.dismiss(animated: true, completion: nil)

            @unknown default:
                print("i")

            }
        }))
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true, completion: nil)
        }
    

}
