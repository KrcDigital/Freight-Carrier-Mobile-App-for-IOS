//
//  is_detail_page.swift
//  CamelPro
//
//  Created by Can Kirac on 20.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SDWebImage

class is_detail_page: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getjetons()
        
        isveren.text = isverenl
        detail.text = detaill
        var fyt = Int(fiyatl)!.formattedWithSeparator
        fiyat.text = "Ücret: \(fyt)TL"
        kalkis.text = kalkisl
        tarihi.text = tarihil
        number.text = numberl
        aracl.text = "Tercih Edilen Araç :\(araclbll)"
        varis.text = varisl
        kilo.text =  "Yük Kilom :\(kilol)"
        izlenme.text = "\(gosterim) Kişi İnceledim"
        iveren_img.sd_setImage(with: URL(string: imgl))
        gosterimsayac()
        getteklifs()
        // Initialization code
    }
    var kilol = ""
    @IBOutlet weak var kilo: UILabel!
    @IBOutlet weak var aracl: UILabel!
    @objc func layoutSubviews() {
        iveren_img.layer.masksToBounds = true
            iveren_img.layer.cornerRadius = iveren_img.bounds.width / 2        }
    var araclbll = ""
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var isveren: UILabel!
    @IBOutlet weak var detail: UITextView!
    var is_id = ""
    @IBOutlet weak var fiyat: UILabel!
    @IBOutlet weak var kalkis: UILabel!
    @IBOutlet weak var odeme_dogrulandimi: UIStackView!
    @IBOutlet weak var varis: UILabel!
    @IBOutlet weak var iveren_img: UIImageView!
    
    @IBOutlet weak var izlenme: UILabel!
    var numberl = ""
    var isverenl = ""
    var detaill = ""
    var fiyatl = ""
    var kalkisl = ""
    var varisl = ""
    var imgl = ""
    var isveren_id = ""
    var gosterim = 0
    
    var icerik_idsi = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tomsj" {

        let destinationVc = segue.destination as! mesaj_in_mesaj
        destinationVc.isveren_id = isveren_id
            
            
        }
        
        if segue.identifier == "basvur_one" {

        let destinationVc = segue.destination as! arac_sec
            destinationVc.icerik_id = is_id
            destinationVc.jeton = jetonum
            
        }
        
        if segue.identifier == "teklif" {

        let destinationVc = segue.destination as! teklifverenler
            destinationVc.icerik_id = is_id
            
            
        }
        
    }
  
    @IBAction func sendmsj(_ sender: Any) {
        if isveren_id != Auth.auth().currentUser?.uid
        {
            performSegue(withIdentifier: "tomsj", sender: nil)
        }
        
    }
    
    @IBAction func teklifler(_ sender: Any) {
        performSegue(withIdentifier: "teklif", sender: nil)
    }
    var tarihil = ""
    @IBOutlet weak var tarihi: UILabel!
    
    @IBAction func basvur(_ sender: Any) {
        if !Auth.auth().currentUser!.isAnonymous {
    
        if uyeligim == "0" {
    
        
        if jetonum >= 1 {
            performSegue(withIdentifier: "basvur_one", sender: nil)

        }
        if jetonum <= 0  {
            self.jetoncheck()
        }
          
        }
        
            
        if uyeligim == "1" {
                showAlertButtonTapped()
            }
        }
            
        if Auth.auth().currentUser!.isAnonymous {
            performSegue(withIdentifier: "uyeol", sender: nil)

        }
         
            
        
    }
    
    
    @objc func gosterimsayac() {
       
        
        
        let firestoredb = Firestore.firestore()
        let newnote = ["gosterim":gosterim + 1] as [String : Any]
        firestoredb.collection("icerikler").document(is_id).setData(newnote, merge: true)
        
        
        
         
        
        
    }
    @IBAction func harita(_ sender: Any) {
        
        let alert = UIAlertController(title: "Hata", message: "Konumu görmek için ilana başvurmalısınız.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
            switch action.style{
                case .default:
                
                print("i")
                
            case .cancel:
                print("i")

            case .destructive:
                print("i")

            @unknown default:
                print("i")

            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func jetoncheck() {
        
        let alert = UIAlertController(title: "Uyarı", message: "Başvuru için jetonunuzun bulunması gerek.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Jeton Al", style: .default, handler: { action in
            switch action.style{
                case .default:
                
                self.performSegue(withIdentifier: "buy_jeton", sender: nil)

                
            case .cancel:
                print("i")

            case .destructive:
                print("i")

            @unknown default:
                print("i")

            }
        }))
        alert.addAction(UIAlertAction(title: "İptal", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var teklifout: UIButton!
    var sayacc = 0
    @objc func getteklifs() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerik_basvuru").whereField("icerik", isEqualTo: is_id).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.sayacc = 0
                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.sayacc = self.sayacc + 1
                            
                          
                        }
                      
                    }

                }
                               
            }
            
            self.teklifout.setTitle("Teklifler(\(self.sayacc))", for: .normal)
            
       }
    }
    
    var jetonum = 0
    
    @objc func getjetons() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("user_id", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.jetonum = doc.get("jeton") as! Int
                            
                          
                        }
                      
                    }

                }
                               
            }
            
            
       }
    }
    
    var uyeligim = "-"
    @objc func showAlertButtonTapped() {

           

        let alert = UIAlertController(title: "Hata", message: "İlanlara sadece nakliyeciler başvurabilir.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
            switch action.style{
                case .default:
                
                print("i")
                
            case .cancel:
                print("i")

            case .destructive:
                print("i")

            @unknown default:
                print("i")

            }
        }))
        self.present(alert, animated: true, completion: nil)
        }
    
    
    
    
    
}

