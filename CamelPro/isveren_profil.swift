//
//  isveren_profil.swift
//  CamelPro
//
//  Created by Can Kirac on 20.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import OneSignal
class isveren_profil: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        getuserinfo()
        create.isUserInteractionEnabled = true
        let createe = UITapGestureRecognizer(target: self, action: #selector(tocreate))
        create.addGestureRecognizer(createe)
        
        
        bekview.isUserInteractionEnabled = true
        let bekleyen = UITapGestureRecognizer(target: self, action: #selector(bekle))
        bekview.addGestureRecognizer(bekleyen)
        
        akview.isUserInteractionEnabled = true
        let aktif = UITapGestureRecognizer(target: self, action: #selector(aktiff))
        akview.addGestureRecognizer(aktif)
        
        
        taview.isUserInteractionEnabled = true
        let tam = UITapGestureRecognizer(target: self, action: #selector(tam))
        taview.addGestureRecognizer(tam)
        // Do any additional setup after loading the view.
        
        gettam()
        getaktif()
        getnakliyecibekleyen()
        
        layoutSubviews()
        onekayit()
        // Initialization code
    }
    @IBOutlet weak var akview: UIView!
    
    @IBOutlet weak var bekview: UIView!
    @IBOutlet weak var taview: UIView!
    @objc func layoutSubviews() {
       userimg.layer.masksToBounds = true
            userimg.layer.cornerRadius = userimg.bounds.width / 2        }

   
    @IBOutlet weak var create: UIStackView!
    @objc func aktiff() {
        performSegue(withIdentifier: "aktif", sender: nil)
    }
    @objc func tam() {
        performSegue(withIdentifier: "tamamlan", sender: nil)
    }
    @objc func bekle() {
        performSegue(withIdentifier: "bekle", sender: nil)
    }
    @objc func tocreate() {
        performSegue(withIdentifier: "tocreate", sender: nil)
    }
    
    var isverenid = ""
    var namee = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tocreate" {
            let destinationVC = segue.destination as! create_step_1
            destinationVC.isveren_id = isverenid
            destinationVC.namee = namee
        }
    }
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var telefon: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    
    @objc func getuserinfo() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("user_id", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.get("user_id") as? String {
                            
                                let docId = doc.documentID
                            
                            self.name.text = "\(doc.get("isim") as! String) \(doc.get("soyisim") as! String)"
                            self.userimg.sd_setImage(with: URL(string: doc.get("user_img") as! String))
                            self.telefon.text = Auth.auth().currentUser?.phoneNumber
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            

        }
        

    }
    
    @IBOutlet weak var tamlbl: UILabel!
    var gettamsayac = 0
    
    func gettam() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerikler").whereField("isveren_id", isEqualTo:  Auth.auth().currentUser?.uid).whereField("durum", isEqualTo: "2" ).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.gettamsayac = 0
                    for doc in  snapshot!.documents {
                        
                        if let id = doc.get("kalkis_yeri"){
                                
                            self.gettamsayac = self.gettamsayac + 1
                            }
 
                        
                    }

                }
            }
            self.tamlbl.text = "\(self.gettamsayac)"
            
            
        
        }
    }
    
    
    @IBOutlet weak var beklyen_lbl: UILabel!
    var aktif_sayac = 0
    var bekleyen_sayac = 0

    @IBOutlet weak var aktiflbl: UILabel!
    
    func getaktif() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerikler").whereField("isveren_id", isEqualTo:  Auth.auth().currentUser?.uid).whereField("durum", isEqualTo: "0" ).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.bekleyen_sayac = 0
                    for doc in  snapshot!.documents {
                        
                        if let id = doc.get("kalkis_yeri"){
                                
                            self.bekleyen_sayac = self.bekleyen_sayac + 1
                            }
 
                        
                    }

                }
            }
            self.beklyen_lbl.text = "\(self.bekleyen_sayac)"
            
            
        
        }
    }
    
    func getnakliyecibekleyen() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerikler").whereField("isveren_id", isEqualTo:  Auth.auth().currentUser?.uid).whereField("durum", isEqualTo: "1" ).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.aktif_sayac = 0
                    
                    for doc in  snapshot!.documents {
                        
                        if let id = doc.get("kalkis_yeri"){
                                
                            self.aktif_sayac = self.aktif_sayac + 1
                            }
 
                        
                    }

                }
            }
            self.aktiflbl.text = "\(self.aktif_sayac)"
            
            
        
        }
    }
    
    
    
    @IBAction func exitt(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Onay", message: "Çıkış işlemini onaylıyor musunuz ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { action in
            switch action.style{
                case .default:
                
                
                
                do {
                    try Auth.auth().signOut()
                    self.performSegue(withIdentifier: "outtoin", sender: nil)
                }catch {
                    let alert = UIAlertController.init(title: "Hata ! ", message: "Çıkış yapılamadı lütfen tekrar deneyin.", preferredStyle: UIAlertController.Style.alert)
                    let alertbutton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(alertbutton)
                    self.present(alert, animated: true, completion: nil)
                }
                
            case .cancel:
                
                
                do {
                    try Auth.auth().signOut()
                    self.performSegue(withIdentifier: "outtoin", sender: nil)
                }catch {
                    let alert = UIAlertController.init(title: "Hata ! ", message: "Çıkış yapılamadı lütfen tekrar deneyin.", preferredStyle: UIAlertController.Style.alert)
                    let alertbutton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(alertbutton)
                    self.present(alert, animated: true, completion: nil)
                }

            case .destructive:
                
                
                do {
                    try Auth.auth().signOut()
                    self.performSegue(withIdentifier: "outtoin", sender: nil)
                }catch {
                    let alert = UIAlertController.init(title: "Hata ! ", message: "Çıkış yapılamadı lütfen tekrar deneyin.", preferredStyle: UIAlertController.Style.alert)
                    let alertbutton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(alertbutton)
                    self.present(alert, animated: true, completion: nil)
                }

            @unknown default:
                print("i")

            }
        }))
        alert.addAction(UIAlertAction(title: "Hayır", style: .cancel))
        self.present(alert, animated: true, completion: nil)
        
        
        
        

    }
    
    
    @IBAction func settig(_ sender: Any) {
        let alert = UIAlertController.init(title: "Uyarı", message: "Bilgiler sadece yönetici tarafından değiştirilebilir", preferredStyle: UIAlertController.Style.alert)
        let alertbutton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertbutton)
        self.present(alert, animated: true, completion: nil)
    }
    let dbase = Firestore.firestore()

    @objc func onekayit() {
        
        
        let deviceState = OneSignal.getDeviceState()
        let userId = deviceState?.userId
            print("OneSignal Push Player ID: ", userId ?? "called too early, not set yet")
        
        if let onenew = userId {
            
            dbase.collection("PlayerId").whereField("numara", isEqualTo:  Auth.auth().currentUser!.phoneNumber).getDocuments { snapshot, error in
                if error != nil {
                    if snapshot?.isEmpty == false && snapshot != nil {
                        for document in snapshot!.documents {
                            if let playimid = document.get("signalid") as? String {
                                
                                if playimid == onenew {
                                    print("esit")
                                }
                                else {
                                    let playerdick = ["numara": Auth.auth().currentUser!.phoneNumber , "signalid" : onenew] as! [String : Any]
                                    
                                    
                                    self.dbase.collection("PlayerId").addDocument(data: playerdick) { error in
                                        if error != nil {
                                            print(error?.localizedDescription)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                    else {
                        let playerdick = ["numara": Auth.auth().currentUser!.phoneNumber , "signalid" : onenew] as! [String : Any]
                        
                        
                        self.dbase.collection("PlayerId").addDocument(data: playerdick) { error in
                            if error != nil {
                                print(error?.localizedDescription)
                            }
                        }
                    }
                }
            }
            
        
        
       
    }
    
    
    

}
