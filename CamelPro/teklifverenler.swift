//
//  teklifverenler.swift
//  CamelPro
//
//  Created by Can Kirac on 27.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SDWebImage

class teklifverenler: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teklifimg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "aktifcel", for: indexPath) as! teklifverenler_cell
       // cell.userid = user_id[indexPath.row]
        cell.aracid = araba_id[indexPath.row]
        cell.fiyat.setTitle("\(fiyat[indexPath.row]) TL", for: .normal)
        print("burası\(araba_id[indexPath.row])- \(user_id[indexPath.row])")
//        let deneme = teklifverenler_cell()
//        let denemetwo = deneme.getuser(idsi: user_id[indexPath.row])
//        denemetwo
//
//        let denemetre = teklifverenler_cell()
//        let denemef = deneme.getaracbilgi(arac: araba_id[indexPath.row])
//        denemef
//
//        let de = deneme.deneme()
//        de
//        cell.fiyat.setTitle("\(fiyat[indexPath.row]) TL", for: .normal)
        
        cell.user_img.sd_setImage(with: URL(string: teklifimg[indexPath.row]))
        cell.username.text = teklifname[indexPath.row]
        cell.aracyili.text = "Araç Yılı : \(aracyili[indexPath.row])"
        cell.aracmarka.text = "Araç Marka : \(aracmarka[indexPath.row])"

        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getaracs()
        tablee.delegate = self
        tablee.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    var icerik_id = ""
    
    @IBOutlet weak var baslik: UILabel!
    
    @IBOutlet weak var tableee: UITableView!
    
    var araba_id = [String]()
    var user_id = [String]()
    var teklifimg = [String]()
    var teklifname = [String]()
    var fiyat = [String]()
    
    var araba_idx = ""
    var nakliyecix = ""
    var sayacc = 0
    @objc func getaracs() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerik_basvuru").whereField("icerik", isEqualTo: icerik_id).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.araba_id.removeAll()
                    
                    self.user_id.removeAll()
                    self.fiyat.removeAll()
                    self.sayacc = 0
                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                                
                            self.araba_id.append(doc.get("arabaid") as! String)
                            self.user_id.append(doc.get("nakliyeci") as! String)
                            self.fiyat.append(doc.get("fiyat") as! String)
                            self.sayacc = self.sayacc + 1
                            self.getuser(userid: doc.get("nakliyeci") as! String)
                            self.getaracbilgi(aracid: doc.get("arabaid") as! String)
                            print("bura\(self.araba_idx)")
                        }
                      
                    }

                }
                               
            }
            self.baslik.text = "Teklif Verenler (\(self.sayacc))"

            

       }
    }
    
    
    var aracmarka = [String]()
    var aracyili = [String]()
    
    @objc func getaracbilgi(aracid : String ) {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("araclar").document(aracid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                   
                            print("girdiiste")
                self.aracmarka.append(snapshot!.get("marka") as! String)
                self.aracyili.append(snapshot!.get("model") as! String)
                print("bura\(snapshot!.get("marka") as! String)")

          

                }
            self.baslik.text = "Teklif Verenler (\(self.sayacc))"
            
            self.tablee.reloadData()
                               
            }
       }
    
    
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
                            print("girdiiste2")

                                
                            self.teklifimg.append(doc.get("user_img") as! String)
                            self.teklifname.append("\(doc.get("isim") as! String) \(doc.get("soyisim") as! String)")

                            self.baslik.text = "Teklif Verenler (\(self.sayacc))"
                            
                            self.tablee.reloadData()
                        }
                      
                    }

                }
                self.baslik.text = "Teklif Verenler (\(self.sayacc))"
                
                //self.tablee.reloadData()
                               
            }
            self.baslik.text = "Teklif Verenler (\(self.sayacc))"
            
           // self.tablee.reloadData()
       }
    }
    
    @IBOutlet weak var tablee: UITableView!
    
}
