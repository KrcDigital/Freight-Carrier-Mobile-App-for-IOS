//
//  aktif_islerimViewController.swift
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

class aktif_islerimViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kalkis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "aktif_cell", for: indexPath) as! ilanlar_cell
        cell.kalkis.text = kalkis[indexPath.row]
        cell.varis.text = varis[indexPath.row]
        cell.arkaplan.image = UIImage(named: kalkis[indexPath.row])
        cell.sirket_img.sd_setImage(with: URL(string: isveren_img[indexPath.row]))
        
        
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tablee.delegate = self
        tablee.dataSource = self
        getonay()
        baslik.text = "Aktif İşlerim (\(kalkis.count))"
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tablee: UITableView!
    @IBOutlet weak var baslik: UILabel!
    
    var is_id = [String]()
    var kalkis = [String]()
    var varis = [String]()
    var realid = [String]()
    func getonay() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("islerim").whereField("durum", isEqualTo: "0").whereField("nakliyeci", isEqualTo:  Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.is_id.removeAll()
                    self.kalkis.removeAll()
                    self.varis.removeAll()
                    
                    
                    for doc in  snapshot!.documents {
                        
                        if let id = doc.get("is_id"){
                            self.realid.append(doc.documentID as! String)
                            self.is_id.append(doc.get("is_id") as! String)
                            self.geticerik(icerik: doc.get("is_id") as! String)
                            }
 
                        
                    }

                }
            }
            self.tablee.reloadData()
           

            
        
        }
    }
    
    
    @IBAction func aramayap(_ sender: Any) {
        
        guard let number = URL(string: "tel://08508888280") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    var doğrulandimi = [String]()
    var isveren_img = [String]()
    
    
    func geticerik(icerik : String) {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerikler").document(icerik).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                
                    
                    
                self.varis.append(snapshot?.get("varis_yeri") as! String)
                self.kalkis.append(snapshot?.get("kalkis_yeri") as! String)
                self.isveren_img.append(snapshot?.get("isveren_img") as! String)
                            
 
                        
                    

                }
            
            self.tablee.reloadData()
            self.baslik.text = "Aktif İşlerim (\(self.kalkis.count))"

            }
           

            
        
        }
    
    var chosen_isid = ""
    var chosenreal = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosen_isid = is_id[indexPath.row]
        chosenreal = realid[indexPath.row]
        performSegue(withIdentifier: "next", sender: nil)
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {

            let destinationVC = segue.destination as! aktif_is_detay
            destinationVC.icerikid = chosen_isid
            destinationVC.realid = chosenreal
            
                
    }
    }

    @IBAction func geri(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func add_segment_change(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0:
            self.getonay()
            

            case 1:
            performSegue(withIdentifier: "toteklif", sender: nil)
        
        case 2:
        performSegue(withIdentifier: "tamam", sender: nil)
            

        default:
            self.getonay()

            
                   }
        
    }
    
    
    
}
