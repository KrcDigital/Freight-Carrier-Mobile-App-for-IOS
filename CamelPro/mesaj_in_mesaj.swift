//
//  mesaj_in_mesaj.swift
//  CamelPro
//
//  Created by Can Kirac on 18.05.2022.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class mesaj_in_mesaj: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msj.count
    }
    var firststring = ""
    var imgstring = ""
    
    @IBOutlet weak var mesajs_view: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mesajs_view.dequeueReusableCell(withIdentifier: "msj_in_cell", for: indexPath) as! mesajlar_in_mesaj_cell
       
        
        firststring = ""
        imgstring = ""
        
        
        
        
        
        
        if kim[indexPath.row] == "1"
            {
           

                cell.mymsj.text = msj[indexPath.row]
            cell.mytarih.text = datee[indexPath.row]
            cell.youmsj.text = ""
            cell.yourdate.text = ""
            
            }
        if kim[indexPath.row] == "0"
            {
            cell.mymsj.text = ""
            cell.mytarih.text = ""

          cell.yourdate.text = datee[indexPath.row]

                cell.youmsj.text = msj[indexPath.row]
            
            
            
                

            }
            olbe = olbe + 1
        
        olbe = 1

        
        return cell
    }

    var olbe = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gecmisvarmi()
        self.mesajs_view.delegate = self
        self.mesajs_view.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
        // Initialization code
    }
    

    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func geri(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var msj_view: UITableView!
    
    var msj_id = [String]()
    var msj = [String]()
    var datee = [String]()
    var kim = [String]()
    var imgurl = [String]()

    var mesaj_id = ""
    
    var sahip = ""
    func getdata() {
        
        self.sahip = Auth.auth().currentUser!.uid
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("mesajlar_history").order(by: "date").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.msj.removeAll()
                    self.datee.removeAll()
                    self.kim.removeAll()
                    
                    
                    for doc in  snapshot!.documents {
                        
                       
                            
                        
                        if doc.get("sender") as! String == Auth.auth().currentUser?.uid {
                            
                            if doc.get("receiver") as! String == self.isveren_id {
                                self.kim.append("1")
                                if let mesajj = doc.get("mesaj") as? String {
                                  
                                        self.msj.append(mesajj)
                                    self.datee.append(doc.get("date") as! String )
                                    
                                }
                                
                            }
                            
                        }
                        
                        if doc.get("receiver") as! String == Auth.auth().currentUser?.uid {
                            if doc.get("sender") as! String == self.isveren_id {
                                self.kim.append("0")
                                if let mesajj = doc.get("mesaj") as? String {
                                    

                                    self.datee.append(doc.get("date") as! String)

                                        self.msj.append(mesajj)

                                    
                                    
                                }
                                
                            }
                        
                        }
       
                        }
                   
                    }

                }
            self.mesajs_view.reloadData()



            }
        

        }
    
    
    var isveren_id = ""
    
    
    @IBOutlet weak var msj_text: UITextField!
    
    @IBAction func send(_ sender: Any) {
        send_msj()
    }
    
    @objc func send_msj() {

        if msj_text.text != "" {
            
        
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = df.string(from: date)

                                
                                let firestore = Firestore.firestore()
            let firestorepacket = ["date":dateString,"receiver":self.isveren_id ,"sender":Auth.auth().currentUser!.uid,"mesaj":self.msj_text.text,"main_id":msj_main_id] as [String : Any]
                                
                                var firestoreref : DocumentReference?
                                firestoreref = firestore.collection("mesajlar_history").addDocument(data: firestorepacket, completion: { error in
                                    if error != nil {
                                        print("hata aldın")
                                    }
                                    else {
                                        self.msj_history_update(last: self.msj_text.text!)
                                        self.msj_text.text = ""
                                        let numberOfSections = self.mesajs_view.numberOfSections
                                        let numberOfRows = self.mesajs_view.numberOfRows(inSection: numberOfSections-1)
                                        self.getdata()
                                        let indexPath = IndexPath(row: numberOfRows-1 , section: numberOfSections-1)
//                                        self.mesajs_view.scrollToRow(at: indexPath, at: .middle, animated: true)
                                        self.msj_text.isEnabled = true

                                    }
                                })
            
        }
            
                            }
    
    
    
    
    var msj_main_id = ""
    
    @objc func gecmisvarmi() {
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("msj_connect").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    
                    
                    for doc in  snapshot!.documents {
                        
                        if doc.get("sender") as! String == Auth.auth().currentUser?.uid {
                            if doc.get("receiver") as! String == self.isveren_id {
                                
                            
                            self.msj_main_id = doc.documentID as! String
                                
                            }
                        }
                        
                        if doc.get("receiver") as! String == Auth.auth().currentUser?.uid {
                            if doc.get("sender") as! String == self.isveren_id {
                                
                            
                            self.msj_main_id = doc.documentID as! String
                                
                            }
                        }
                        
                        
                    }
                        
                }
        
    }
            if self.msj_main_id == "" {
                
                let firestore = Firestore.firestore()
let firestorepacket = ["receiver":self.isveren_id ,"sender":Auth.auth().currentUser!.uid] as [String : Any]
                
                var firestoreref : DocumentReference?
                firestoreref = firestore.collection("msj_connect").addDocument(data: firestorepacket, completion: { error in
                    if error != nil {
                        print("hata aldın")
                    }
                    else {
                        
                        self.getdata()
                    }
                })
                
            }
            else {
                self.getdata()

            }
            
            
        }
    }
    
    
    func msj_history_update(last : String) {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        
        
        let firestoredb = Firestore.firestore()
        let newnote = ["last":last,"last_date":dateString ] as [String : Any]
        firestoredb.collection("msj_connect").document(msj_main_id).setData(newnote, merge: true)
        
        
        
         
        
        
    }
    
    
    
    
}
