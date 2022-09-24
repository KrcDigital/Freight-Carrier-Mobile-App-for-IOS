//
//  tekliflerim.swift
//  CamelPro
//
//  Created by Can Kirac on 6.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class tekliflerim: UIViewController , UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kalkis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "aktif_cell", for: indexPath) as! tekliflerimviewcell
        cell.kalkis.text = kalkis[indexPath.row]
        cell.varis.text = varis[indexPath.row]
        cell.img.image = UIImage(named: kalkis[indexPath.row])
        cell.fiyat.text = "\(fiyats[indexPath.row]) TL"
        cell.idsi = realid[indexPath.row]
        
        return cell
        
    }
    @IBAction func aramayap(_ sender: Any) {
        
        guard let number = URL(string: "tel://08508888280") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tablee.delegate = self
        tablee.dataSource = self
        getonay()
        // Do any additional setup after loading the view.
    }
    
    var isid = [String]()
    var kalkis = [String]()
    var varis = [String]()
    var fiyats = [String]()
    var realid = [String]()
    
    
    func getonay() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerik_basvuru").whereField("nakliyeci", isEqualTo:  Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.isid.removeAll()
                    self.kalkis.removeAll()
                    self.varis.removeAll()
                    
                    
                    for doc in  snapshot!.documents {
                        
                        if let id = doc.get("icerik"){
                            self.realid.append(doc.documentID as! String)
                            self.isid.append(doc.get("icerik") as! String)
                            self.fiyats.append(doc.get("fiyat") as! String)
                            self.geticerik(icerik: doc.get("icerik") as! String)
                            }
 
                        
                    }

                }
            }
            self.tablee.reloadData()
           

            
        
        }
    }
    @IBOutlet weak var baslik: UILabel!
    @IBOutlet weak var tablee: UITableView!
    
    func geticerik(icerik : String) {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerikler").document(icerik).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                
                if snapshot?.exists == true  {
           
                self.varis.append(snapshot!.get("varis_yeri") as! String)
                self.kalkis.append(snapshot!.get("kalkis_yeri") as! String)

                    
                }
                    
                        
                    

                }
            
            self.tablee.reloadData()
            self.baslik.text = "Tekliflerim (\(self.kalkis.count))"

            }
           

            
        
        }
    
    @IBAction func add_segment_change(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0:
            performSegue(withIdentifier: "geri", sender: nil)


            case 1:
                getonay()
        case 2:
        performSegue(withIdentifier: "tamam", sender: nil)
            

        default:
            self.getonay()

            
                   }
        
    }
    
    @IBAction func geri(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sil(_ sender: Any) {
        
    }
    
    var chosenid = ""
    var realchose = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenid = isid[indexPath.row]
        realchose = realid[indexPath.row]
        performSegue(withIdentifier: "git", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "git" {
            let dest = segue.destination as! teklif_vieww
            dest.icerikid = chosenid
            dest.realid = realchose
        }
        
    }
    
    
}
