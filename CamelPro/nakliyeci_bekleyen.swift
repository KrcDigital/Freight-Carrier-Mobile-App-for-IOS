//
//  nakliyeci_bekleyen.swift
//  CamelPro
//
//  Created by Can Kirac on 5.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class nakliyeci_bekleyen: UIViewController , UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return is_id.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "aktif_cell", for: indexPath) as! nakliye_bekleyen_cell
        cell.kalkis.text = kalkis[indexPath.row]
        cell.varis.text = varis[indexPath.row]
        cell.img.image = UIImage(named: kalkis[indexPath.row])
        cell.idsi = is_id[indexPath.row]
        
        
        
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getonay()
        self.baslik.text = "Nakliyeci Bekleyen (\(sayacbasvuru))"

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var baslik: UILabel!
    
    @IBOutlet weak var tablee: UITableView!
    
    var is_id = [String]()
    var kalkis = [String]()
    var varis = [String]()
    
    
    
    func getonay() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerikler").whereField("isveren_id", isEqualTo:  Auth.auth().currentUser?.uid).whereField("durum", isEqualTo: "0").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.is_id.removeAll()
                    self.kalkis.removeAll()
                    self.varis.removeAll()
                    
                    
                    for doc in  snapshot!.documents {
                        
                        if let id = doc.get("kalkis_yeri"){
                                
                            print("bekleyengirdi")
                            self.is_id.append(doc.documentID as! String)
                                self.kalkis.append(doc.get("kalkis_yeri") as! String)
                                self.varis.append(doc.get("varis_yeri") as! String)
                            self.getbasvurular(idsi: doc.documentID as! String)
                            }
 
                        
                    }

                }
            }
            self.tablee.dataSource = self
            self.tablee.delegate = self
            self.tablee.reloadData()
            self.baslik.text = "Nakliyeci Bekleyen (\(self.sayacbasvuru))"

            
        
        }
    }
    var basvuranlar = [Int]()
    var sayacbasvuru = 0
    
    func getbasvurular(idsi : String) {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerik_basvuru").whereField("icerik", isEqualTo:  idsi).addSnapshotListener { snapshot, error in
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
            
            self.basvuranlar.append(self.sayacbasvuru)
            self.baslik.text = "Nakliyeci Bekleyen (\(self.sayacbasvuru))"

            
        
        }
    }
    
    
    @IBAction func aramayap(_ sender: Any) {
        
        guard let number = URL(string: "tel://08508888280") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    var chosenisid = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosenisid = is_id[indexPath.row]
        performSegue(withIdentifier: "view", sender: nil)
        
        
    }
    
    var chosenpackrekor = "0"
    var chosensahib = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "start" {
            let destiantionVC = segue.destination as! ilan_basvurularim
            
            destiantionVC.icerik_id = chosenisid
            
            
    }
        if segue.identifier == "view" {
                let destiantionV = segue.destination as! nak_view
            destiantionV.is_id = chosenisid
                
        }
    
}
    
    @IBAction func gitt(_ sender: Any) {

    }
    @objc func git() {
        performSegue(withIdentifier: "start", sender: nil)

    }
    
    @IBAction func sil(_ sender: Any) {
        
    }
    
}
