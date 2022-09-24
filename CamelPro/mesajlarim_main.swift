//
//  mesajlarim_main.swift
//  CamelPro
//
//  Created by Can Kirac on 23.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class mesajlarim_main: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mesaj_view.dataSource = self
        self.mesaj_view.delegate = self
        getmain()
        
        
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return username.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mesaj_view.dequeueReusableCell(withIdentifier: "msj", for: indexPath) as! mesajlar_main_cell
        cell.user_name.text = username[indexPath.row]
        cell.user_img.sd_setImage(with: URL(string: userimg[indexPath.row]))
        cell.last.text = lastmsj[indexPath.row]
        cell.date.text = lastdate[indexPath.row]
        cell.user_id = msj_user[indexPath.row]
        
        
        return cell
        
    }
    
    
    
    var sahip = ""
    
    var msj_id = [String]()
    var msj_user = [String]()
    var lastmsj = [String]()
    var lastdate = [String]()

    @IBOutlet weak var mainlbl: UILabel!
    var sayac = 0
    func getmain() {
        
        self.sahip = Auth.auth().currentUser!.uid
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("msj_connect").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.msj_id.removeAll()
                    self.msj_user.removeAll()
                    self.lastmsj.removeAll()
                    self.lastdate.removeAll()
                    self.sayac = 0
                    self.username.removeAll()
                    self.userimg.removeAll()
                    
                    for doc in  snapshot!.documents {
                       
                        if doc.get("sender") as! String == Auth.auth().currentUser?.uid {
                            
                            self.msj_id.append(doc.documentID as! String)
                            self.msj_user.append(doc.get("receiver") as! String)
                            self.getuserinfo(userid: doc.get("receiver") as! String)
                            self.lastmsj.append(doc.get("last") as! String)
                            self.lastdate.append(doc.get("last_date") as! String)
                            self.sayac = self.sayac + 1

                        }
                        
                        if doc.get("receiver") as! String == Auth.auth().currentUser?.uid {
                            self.msj_id.append(doc.documentID as! String)
                            self.msj_user.append(doc.get("sender") as! String)
                            self.getuserinfo(userid: doc.get("sender") as! String)
                            self.lastmsj.append(doc.get("last") as! String)
                            self.lastdate.append(doc.get("last_date") as! String)
                            self.sayac = self.sayac + 1
                    
                        }
                        
                      
                        
                        }
                   
                    }
               

                }
           
            self.mesaj_view.dataSource = self
            self.mesaj_view.delegate = self
            self.mesaj_view.reloadData()
            self.mainlbl.text = "Mesajlarım (\(self.sayac))"


            }
        

        }
    
    @IBOutlet weak var mesaj_view: UITableView!
    
    var chosenid = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosenid = msj_user[indexPath.row]
        print("bastın!!")
        performSegue(withIdentifier: "start", sender: nil)
        
        
    }
    
    var chosenpackrekor = "0"
    var chosensahib = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "go2sirket" {
            let desttwo = segue.destination as! isveren_profil
            
            
        }
        if segue.identifier == "start" {
            let dest = segue.destination  as! mesaj_in_mesaj
            dest.isveren_id = chosenid
        }
    
}
    var username = [String]()
    var userimg = [String]()
    
    @IBOutlet weak var ds: UIView!
    @IBAction func geri(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    func getuserinfo(userid : String) {
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("user_id", isEqualTo: userid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    
                    
                    for doc in  snapshot!.documents {
                        

                        self.username.append("\(doc.get("isim") as! String)  \(doc.get("soyisim") as! String)")
                        self.userimg.append(doc.get("user_img") as! String)
                        
                        print("usernamesi \(self.username)")

                        
                        
                      
                        
                        }
                   
                    }
               
                


                }
            self.mesaj_view.reloadData()


            }
        

        }
    
    
    @objc func deneme() {
        print("bu")
    }
    
    
    
    
}
