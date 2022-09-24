//
//  ilan_basvurularim.swift
//  CamelPro
//
//  Created by Can Kirac on 5.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SDWebImage


class ilan_basvurularim: UIViewController , UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aracyili.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! teklifverenler_cell
        cell.username.text = teklifname[indexPath.row]
       
            cell.aracyili.text = "Araç Yılı : \(aracyili[indexPath.row])"
            cell.aracmarka.text = "Araç Marka : \(aracmarka[indexPath.row])"

        
        cell.user_img.sd_setImage(with: URL(string: teklifimg[indexPath.row]))


        

        
        cell.fiyat.setTitle("\(fiyat[indexPath.row]) TL", for: .normal)
        
        
        
        return cell
        
    }

    @IBAction func aramayap(_ sender: Any) {
        
        guard let number = URL(string: "tel://08508888280") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    var realimid = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getaracs()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
           // Code you want to be delayed
        }
        self.baslik.text = "Başvuranlar (\(self.aracyili.count))"
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var baslik: UILabel!
    
    var araba_id = [String]()
    var user_id = [String]()
    var fiyat = [String]()
    var basvuru_msj = [String]()
    var sayacc = 0


    @IBOutlet weak var tablee: UITableView!
    var icerik_id = ""
    @objc func getaracs() {
        
        print("hataburadamı3")


        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerik_basvuru").whereField("icerik", isEqualTo: icerik_id).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.araba_id.removeAll()
                    self.aracmarka.removeAll()
                    self.aracyili.removeAll()
                    self.teklifimg.removeAll()
                    self.teklifname.removeAll()
                    self.user_id.removeAll()
                    self.nakliyeci_numara.removeAll()
                    self.fiyat.removeAll()
                    self.arac_imgs.removeAll()
                    self.basvuru_msj.removeAll()
                    self.realimid.removeAll()
                    self.sayacc = 0
                    print("hataburadamı2")

                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            print("hataburadamı")
                                
                           self.araba_id.append(doc.get("arabaid") as! String)
                            print("hataburadamı4 \(self.araba_id.count)")

                                self.user_id.append(doc.get("nakliyeci") as! String)
                          self.fiyat.append(doc.get("fiyat") as! String)
                            self.basvuru_msj.append(doc.get("basvuru_msj") as! String)

                          self.sayacc = self.sayacc + 1
                            self.getaracbilgi(aracid: doc.get("arabaid") as! String)
                            self.getuser(userid: doc.get("nakliyeci") as! String)
                            self.realimid.append(doc.documentID)
                        }
                      
                    }

                }
                               
            }
            

       }
    }
    
    
    
    
    @objc func getaracbilgi(aracid : String ) {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("araclar").document(aracid).addSnapshotListener { snapshot, error in
            if error != nil {
                print("error")
                
                
            }
            else {
                if snapshot!.exists
                {
                
                            
                self.aracmarka.append(snapshot!.get("marka") as! String)
             self.aracyili.append(snapshot!.get("model") as! String)
                self.arac_imgs.append(snapshot!.get("img") as! String)
                print("bura\(snapshot!.get("marka") as! String)")
                    
                }
                
                else {
                    self.aracmarka.append("--")
                 self.aracyili.append("--")
                    self.arac_imgs.append("--")
                }
          

                }
          

                               
            }
       }
    var selid = ""
    var teklifidsi = [String]()
    var arac_imgs = [String]()
    var aracmarka = [String]()
    var aracyili = [String]()
    var nakliyeci_numara = [String]()
    var teklifimg = [String]()
    var teklifname = [String]()
    
    @objc func getuser(userid : String) {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("user_id", isEqualTo: userid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            print("hataburadamı5")

                            self.nakliyeci_numara.append(doc.get("numara") as! String)

                            self.teklifimg.append(doc.get("user_img") as! String)
                            self.teklifname.append("\(doc.get("isim") as! String) \(doc.get("soyisim") as! String)")

                          
                        }
                      
                    }

                }
                               
            }
            self.tablee.delegate = self
            self.tablee.dataSource = self
            self.tablee.reloadData()
            self.baslik.text = "Başvuranlar (\(self.teklifname.count))"

       }
    }
    
    
    @IBOutlet weak var detayview: UIView!
    
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBAction func kapat(_ sender: Any) {
        detayview.isHidden = true
        blur.isHidden = true
    }
    @IBOutlet weak var tekliffiyatlbl: UILabel!
    @IBOutlet weak var aracyililbl: UILabel!
    @IBOutlet weak var aracmarkalbl: UILabel!
    @IBOutlet weak var aracimg: UIImageView!
    @IBOutlet weak var basvurumsj: UITextView!
    @IBOutlet weak var numara: UILabel!
    @IBOutlet weak var nakliyecimg: UIImageView!
    @IBOutlet weak var nakliyecilbl: UILabel!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        nakliyecilbl.text = teklifname[indexPath.row]
        nakliyecimg.sd_setImage(with: URL(string: teklifimg[indexPath.row]))
        numara.text = nakliyeci_numara[indexPath.row]
        basvurumsj.text = basvuru_msj[indexPath.row]
        aracimg.sd_setImage(with: URL(string: arac_imgs[indexPath.row]))
        aracmarkalbl.text = "Araç Marka : \(aracmarka[indexPath.row])"
        aracyililbl.text = "Araç Yılı : \(aracyili[indexPath.row])"
        tekliffiyatlbl.text = "\(fiyat[indexPath.row]) TL"
        chosenfiyat = "\(fiyat[indexPath.row]) TL"
        nakliyeciid = user_id[indexPath.row]
        detayview.isHidden = false
        blur.isHidden = false
        busonid = realimid[indexPath.row]

        
        
        
    }
    
    var busonid = ""
    var chosenid = ""
    var chosenfiyat = ""
    var chosenpackrekor = "0"
    var chosensahib = ""
    
    var nakliyeciid = ""
    
    @IBAction func onayla(_ sender: Any) {
        
        
        showAlertButtonTapped()
        
    }
    
    @objc func silmee(reids : String) {
        let db = Firestore.firestore()
        db.collection("icerik_basvuru").document(reids).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)

                self.dismiss(animated: true, completion: nil)
            }
    }
    }
    
    @objc func basvuruonayla() {

        
            
        
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = df.string(from: date)

                                
                                let firestore = Firestore.firestore()
        let firestorepacket = ["date":dateString,"is_id":self.icerik_id,"fiyat":chosenfiyat,"nakliyeci":nakliyeciid,"durum":"0","bitme_tarihi":"-"] as [String : Any]
                                
                                var firestoreref : DocumentReference?
                                firestoreref = firestore.collection("islerim").addDocument(data: firestorepacket, completion: { error in
                                    if error != nil {
                                        print("hata aldın")
                                    }
                                    else {
                                        self.silmee(reids: self.busonid)
                                        self.updateilan()
                                        self.performSegue(withIdentifier: "geri", sender: nil)

                                    }
                                })
            
        }
            
                 
    
    @objc func showAlertButtonTapped() {

           

        let alert = UIAlertController(title: "Onay", message: "İşin nakliyeciye verilmesini onaylıyor musunuz ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { action in
            switch action.style{
                case .default:
                
                self.basvuruonayla()
                
            case .cancel:
                self.basvuruonayla()

            case .destructive:
                self.basvuruonayla()

            @unknown default:
                print("i")

            }
        }))
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true, completion: nil)
        }
    
    
    
    func updateilan() {
       
        
        let firestoredb = Firestore.firestore()
        let newnote = ["durum":"1","isi_alan":nakliyeciid] as [String : Any]
        firestoredb.collection("icerikler").document(icerik_id).setData(newnote, merge: true)
        
        
        
         
        
        
    }
    
    
    @IBAction func toprof(_ sender: Any) {
        print("bastıncek")
        performSegue(withIdentifier: "toprofil", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toprofil" {
     
        let destinationVC = segue.destination as! profilother
        destinationVC.profid = nakliyeciid
            
        }
    }
    
}
