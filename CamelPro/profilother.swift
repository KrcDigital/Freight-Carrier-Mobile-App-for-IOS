//
//  profilother.swift
//  CamelPro
//
//  Created by Can Kirac on 12.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import SDWebImage
class profilother: UIViewController , UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablee.delegate = self
        tablee.dataSource = self
        
        getisler()
        getuserinfo()
        getuseryorum()
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var imgl: UIImageView!
    
    @IBOutlet weak var confirm: UIStackView!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var star: UILabel!
    
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var tablee: UITableView!
    @IBOutlet weak var aktif: UILabel!
    @IBOutlet weak var iptal: UILabel!
    @IBOutlet weak var tamamlanmis: UILabel!
    @objc func getuserinfo() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("user_id", isEqualTo: profid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.get("user_id") as? String {
                            
                                let docId = doc.documentID
                            
                            self.username.text = "\(doc.get("isim") as! String) \(doc.get("soyisim") as! String)"
                            self.lbl.text = "\(self.username.text!)'in Profili"
                            self.imgl.sd_setImage(with: URL(string: doc.get("user_img") as! String))
                            self.tel.text = doc.get("numara") as! String
                            self.star.text = "\(doc.get("star") as! String)/5"
                        }
                      
                    }
                }
            }
        }
    }
    var profid = ""
    var tamam = [String]()
    var iptall = [String]()
    var aktiff = [String]()
    @objc func getisler() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("islerim").whereField("nakliyeci", isEqualTo: profid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.tamam.removeAll()
                    self.iptall.removeAll()
                    self.aktiff.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.get("nakliyeci") as? String {
                            
                                let docId = doc.documentID
                                
                            if doc.get("durum") as! String == "0" {
                                self.aktiff.append("1")
                            }
                            if doc.get("durum") as! String == "1" {
                                self.tamam.append("1")
                            }
                            if doc.get("durum") as! String == "2" {
                                self.iptall.append("1")
                            }
                      
                    }
                }
            }
        }
            self.tamamlanmis.text = "\(self.tamam.count) Tamamlanmış Nakliye"
            self.iptal.text = "\(self.iptall.count) İptal Olan Nakliye"
            self.aktif.text = "\(self.aktiff.count) Aktif Nakliye"

    }
    }
    
    var yazan = [String]()
    
    @IBOutlet weak var imgtext: UIImageView!
    @IBOutlet weak var usertext: UILabel!
    @IBOutlet weak var puantext: UILabel!
    @IBOutlet weak var yorumtext: UITextView!
    var yorumg = [String]()
    var yazanname = [String]()
    var yazanimg = [String]()
    var yorumpuan = [String]()
    @objc func getuseryorum() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("degerlendirme").whereField("sahip", isEqualTo: profid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.yazan.removeAll()
                    self.yorumg.removeAll()
                    self.yorumpuan.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.get("sahip") as? String {
                            
                                let docId = doc.documentID
                            
                            self.yazan.append(doc.get("sahip") as! String)
                            self.yorumg.append(doc.get("yorum") as! String)
                         //   self.yorumpuan.append(doc.get("puan") as! String)
                            self.getuseryoruminfo(useridsi: doc.get("sahip") as! String)
                        }
                      
                    }
                }
            }
            
        }
    }
    
    @objc func getuseryoruminfo(useridsi : String) {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("user_id", isEqualTo: useridsi).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.get("user_id") as? String {
                            
                                let docId = doc.documentID
                            
                            self.yazanname.append("\(doc.get("isim") as! String) \(doc.get("soyisim") as! String )")
                            self.yazanimg.append(doc.get("user_img") as! String)
                        }
                      
                    }
                }
            }
            self.yorumsayisi.text = "İşveren Yorumları (\(self.yazan.count))"
            self.tablee.reloadData()
        }
    }
    @IBOutlet weak var yorumsayisi: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yorumg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! user_yorumcell
        cell.name.text = yazanname[indexPath.row]
        cell.textt.text = yorumg[indexPath.row]
        //cell.puan.text = "\(yorumpuan[indexPath.row])"
        
        cell.imgg.sd_setImage(with: URL(string: yazanimg[indexPath.row]))
        
        
        
        return cell
        
    }
    
    @IBAction func geri(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
}
