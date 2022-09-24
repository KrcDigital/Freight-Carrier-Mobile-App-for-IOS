//
//  arac_sec.swift
//  CamelPro
//
//  Created by Can Kirac on 21.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SDWebImage

class arac_sec: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plakalar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "araccell", for: indexPath) as! arac_sec_cell
        cell.arac_id = ids[indexPath.row]
        cell.arac_img.sd_setImage(with: URL(string: imgs[indexPath.row]))
        cell.durumid = durumlar[indexPath.row]
        cell.plaka.text = plakalar[indexPath.row]
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        getuserinfo()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var araccell: UITableView!
    var plakalar = [String]()
    var durumlar = [Int]()
    var imgs = [String]()
    var ids = [String]()

    var jeton = 0
    @IBOutlet weak var aracnumber: UILabel!
    @objc func getuserinfo() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("araclar").whereField("sahip", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.plakalar.removeAll()
                    self.imgs.removeAll()
                    self.durumlar.removeAll()
                    self.ids.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                                
                            self.ids.append(doc.documentID as! String)
                            self.plakalar.append(doc.get("plaka") as! String)
                           self.durumlar.append(doc.get("durum") as! Int)
                            self.imgs.append(doc.get("img") as! String)
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            self.tablee.dataSource = self
            self.tablee.delegate = self
            self.tablee.reloadData()
            self.aracnumber.text = "Araç Seçin(\(self.plakalar.count))"
            

        }
        

    }
    
   var chosencar = ""
    var chosencarimg = ""
    var chosencarplaka = ""
    @IBOutlet weak var tablee: UITableView!
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosencar = ids[indexPath.row]
        chosencarimg = imgs[indexPath.row]
        chosencarplaka = plakalar[indexPath.row]


        performSegue(withIdentifier: "next", sender: nil)
        
        
    }
    
    var chosenpackrekor = "0"
    var chosensahib = ""
    var icerik_id = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            let destiantionVC = segue.destination as! basvuru
            destiantionVC.arabaid = chosencar
            destiantionVC.plakano = chosencarplaka
            destiantionVC.imgurl = chosencarimg
            destiantionVC.icerik_id = icerik_id
            destiantionVC.jetonum = jeton
            
    }
        
    
}
    
}
