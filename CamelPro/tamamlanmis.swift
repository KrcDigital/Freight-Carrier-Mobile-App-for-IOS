//
//  tamamlanmis.swift
//  CamelPro
//
//  Created by Can Kirac on 6.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SDWebImage
class tamamlanmis: UIViewController , UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kalkis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: "aktif_cell", for: indexPath) as! isveren_aktif_cell
        cell.kalkis.text = kalkis[indexPath.row]
        cell.varis.text = varis[indexPath.row]
        cell.img.image = UIImage(named: kalkis[indexPath.row])

        cell.user_img.sd_setImage(with: URL(string: imgss[indexPath.row]))
        cell.user_name.text = names[indexPath.row]
        cell.numara.text = numbers[indexPath.row]
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tablee.delegate = self
        tablee.dataSource = self
        getonay()
        // Do any additional setup after loading the view.
    }
    @IBAction func aramayap(_ sender: Any) {
        
        guard let number = URL(string: "tel://08508888280") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    var isid = [String]()
    var kalkis = [String]()
    var varis = [String]()
    var fiyats = [String]()
    
    @IBOutlet weak var tablee: UITableView!
    
    func getonay() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("islerim").whereField("nakliyeci", isEqualTo:  Auth.auth().currentUser?.uid).whereField("durum", isEqualTo:  "1").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.isid.removeAll()
                    self.kalkis.removeAll()
                    self.varis.removeAll()
                    
                    
                    for doc in  snapshot!.documents {
                        
                        if let id = doc.get("is_id"){
                                
                            self.isid.append(doc.get("is_id") as! String)
                            self.geticerik(icerik: doc.get("is_id") as! String)
                            }
 
                        
                    }

                }
            }
           

            
        
        }
    }
    @IBOutlet weak var baslik: UILabel!
    
    var numbers = [String]()
    var names = [String]()
    var imgss = [String]()
    func geticerik(icerik : String) {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("icerikler").document(icerik).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                
                    
                if snapshot?.exists == true  {
                self.varis.append(snapshot?.get("varis_yeri") as! String)
                self.kalkis.append(snapshot?.get("kalkis_yeri") as! String)
                self.numbers.append(snapshot?.get("telefon") as! String)
                self.names.append(snapshot?.get("isveren") as! String)
                self.imgss.append(snapshot?.get("isveren_img") as! String)

                }
                        
                    

                }
            
            self.tablee.reloadData()
            self.baslik.text = "Tamamlanmış (\(self.kalkis.count))"

            }
           

            
        
        }
    
    @IBAction func add_segment_change(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0:
            performSegue(withIdentifier: "aktif", sender: nil)


            case 1:
            performSegue(withIdentifier: "teklif", sender: nil)

        case 2:
            self.getonay()

        default:
            self.getonay()

            
                   }
        
    }

    @IBAction func geri(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)

            self.dismiss(animated: true, completion: nil)
        
    }
}
