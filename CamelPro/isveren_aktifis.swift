//
//  isveren_aktifis.swift
//  CamelPro
//
//  Created by Can Kirac on 5.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SDWebImage

class isveren_aktifis: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isi_alan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "aktif_cell", for: indexPath) as! isveren_aktif_cell
       // cell.kalkis.text = kalkis[indexPath.row]
        cell.varis.text = varis[indexPath.row]
        cell.img.image = UIImage(named: kalkis[indexPath.row])
        cell.user_name.text =  isi_alan[indexPath.row]
        cell.user_img.sd_setImage(with: URL(string: alan_img[indexPath.row]))
        cell.numara.text = isi_numara[indexPath.row]
        
        
        return cell
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tablee.dataSource = self
        self.tablee.delegate = self
        getonay()
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var baslik: UILabel!
    var is_id = [String]()
    var kalkis = [String]()
    var varis = [String]()
    var isi_alan = [String]()
    var alan_img = [String]()
    var isi_numara = [String]()
    
    @IBOutlet weak var tablee: UITableView!
    func getonay() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerikler").whereField("isveren_id", isEqualTo:  Auth.auth().currentUser?.uid).whereField("durum", isEqualTo: "1" ).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.is_id.removeAll()
                    self.kalkis.removeAll()
                    self.varis.removeAll()
                    self.isi_alan.removeAll()
                    self.isi_numara.removeAll()
                    self.alan_img.removeAll()
                    
                    for doc in  snapshot!.documents {
                        
                        if let id = doc.get("kalkis_yeri"){
                                
                            self.is_id.append(doc.documentID as! String)
                                self.kalkis.append(doc.get("kalkis_yeri") as! String)
                                self.varis.append(doc.get("varis_yeri") as! String)
                            self.getnakliyeci(idsi: doc.get("isi_alan") as! String)
                            }
 
                        
                    }

                }
            }
            
            
            
        
        }
    }
    
    
    func getnakliyeci(idsi: String) {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("user_id", isEqualTo:  idsi).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                   
                    
                    
                    for doc in  snapshot!.documents {
                        
                        if let id = doc.get("isim"){
                                
                            self.isi_alan.append("\(doc.get("isim") as! String) \(doc.get("soyisim") as! String)")
                            self.isi_numara.append(doc.get("numara") as! String)
                            self.alan_img.append(doc.get("user_img") as! String)
                            }
 
                        
                    }

                }
            }
            
            self.tablee.reloadData()
            self.baslik.text = "Aktif İlanlarım (\(self.isi_alan.count))"
            
            
        
        }
        
    }

    
    @IBAction func aramayap(_ sender: Any) {
        
        guard let number = URL(string: "tel://08508888280") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    @IBAction func geri(_ sender: Any) {
    }
}
