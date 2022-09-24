//
//  bildirimpage.swift
//  CamelPro
//
//  Created by Can Kirac on 12.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class bildirimpage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablee.delegate = self
        tablee.dataSource = self
        
        getbildirim()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baslik.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! bildirimcel
        cell.baslik.text = baslik[indexPath.row]
        cell.bildirim.text = textt[indexPath.row]
        
        
        
        
        
        return cell
        
    }

    var baslik = [String]()
    var textt = [String]()
    
    @IBAction func geri(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tablee: UITableView!
    
    @IBOutlet weak var lbll: UILabel!
    @objc func getbildirim() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("bildirimler").whereField("sahip", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.baslik.removeAll()
                    self.textt.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.get("sahip") as? String {
                            
                                let docId = doc.documentID
                            
                            self.baslik.append(doc.get("baslik") as! String)
                            self.textt.append(doc.get("text") as! String)
                        }
                      
                    }
                }
            }
            self.lbll.text = " Bildirimler (\(self.baslik.count))"
            self.tablee.reloadData()
            
        }
    }
    
}
