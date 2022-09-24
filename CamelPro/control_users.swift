//
//  control_users.swift
//  CamelPro
//
//  Created by Can Kirac on 5.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class control_users: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        getusers()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return username.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "aktif_cell", for: indexPath) as! control_usercell
        cell.username.text = username[indexPath.row]
        cell.img.sd_setImage(with: URL(string: user_img[indexPath.row]))
        
        
        
        return cell
        
    }
    @IBOutlet weak var baslik: UILabel!
    
    var user_ids = [String]()
    var user_img = [String]()
    var user_number = [String]()
    var kurumsal = [String]()
    var odeme = [String]()
    var username = [String]()
    var sayac = 0
    @objc func getusers() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.user_ids.removeAll()
                    self.user_img.removeAll()
                    self.kurumsal.removeAll()
                    self.odeme.removeAll()
                    self.user_number.removeAll()
                    self.username.removeAll()
                    self.sayac = 0
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                                
                            self.user_ids.append(doc.get("user_id") as! String)
                            self.user_img.append(doc.get("user_img") as! String)
                           // self.odeme.append(doc.get("odeme") as! String)
                            self.username.append("\(doc.get("isim") as! String)  \(doc.get("soyisim") as! String)")
                           // self.odeme.append(doc.get("kurumsal") as! String)
                            self.sayac = self.sayac + 1
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            self.baslik.text = "Kullanıcılar (\(self.sayac))"
            self.tablee.delegate = self
            self.tablee.dataSource = self
            self.tablee.reloadData()
            

        }
        

    }
    @IBOutlet weak var detay: UIView!
    @IBAction func kapa(_ sender: Any) {
        detay.isHidden = true
    }
    @IBOutlet weak var detayimg: UIImageView!
    @IBOutlet weak var detayname: UILabel!
    @IBOutlet weak var tablee: UITableView!
    
    
    @IBOutlet weak var kurumsalbtno: UISwitch!
    @IBAction func odemebtn(_ sender: Any) {
    }
    @IBAction func kurumsalbtn(_ sender: Any) {
    }
    @IBOutlet weak var odemebtno: UISwitch!
    var chosenusername = ""
    var chosenimg = ""
    var chosenkurumsal = 0
    var chosenodeme = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detayname.text = username[indexPath.row]
        detayimg.sd_setImage(with: URL(string: user_img[indexPath.row]))
        if kurumsal[indexPath.row] == "0" {
            kurumsalbtno.isOn = false
        }
        if kurumsal[indexPath.row] == "1" {
            kurumsalbtno.isOn = true
        }
        
        if odeme[indexPath.row] == "0" {
            odemebtno.isOn = false
        }
        if odeme[indexPath.row] == "1" {
            odemebtno.isOn = true
        }
        
        detay.isHidden = false

       
        
        
    }
}
