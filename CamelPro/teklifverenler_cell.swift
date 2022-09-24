//
//  teklifverenler_cell.swift
//  CamelPro
//
//  Created by Can Kirac on 27.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SDWebImage

class teklifverenler_cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        getaracbilgi(arac: aracid)
//        getuser(idsi: userid)
//        print("burası\(aracid)- \(userid)")
//        user_img.sd_setImage(with: URL(string: imgurl))
//        aracmarka.text = markal
//        aracyili.text = yilil
//        username.text = namel
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        getaracbilgi(arac: aracid)
//        getuser(idsi: userid)
//        self.username.text = self.namel
//        self.user_img.sd_setImage(with: URL(string: self.imgurl))
//        self.aracmarka.text = self.markal
//        self.aracyili.text = self.yilil
        // Configure the view for the selected state
    }
    @IBOutlet weak var uss: UILabel!
    @IBOutlet weak var fiyat: UIButton!
    @IBOutlet weak var aracyili: UILabel!
    
    @IBOutlet weak var aracmarka: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var user_img: UIImageView!
    
    var aracid = ""
    
    var imgurl = ""
    var namel = ""
    var markal = ""
    var yilil = ""
    
    @objc func getaracbilgi(arac : String) {
        
        

        let firestoredb = Firestore.firestore()
        
        print("burası-1 \(arac)")
        firestoredb.collection("araclar").document(arac).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                

            }
            else {
                   
                            
                self.markal = snapshot!.get("marka") as! String
                self.yilil = snapshot!.get("model") as! String

          

                }

                               
            }
       }
    
    var userid = ""
    @objc func getuser(idsi : String) {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("user_id", isEqualTo: idsi).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            print("burası-2 \(idsi)")

                            self.imgurl = doc.get("user_img") as! String
                            self.namel = "\(doc.get("isim") as! String) \(doc.get("soyisim") as! String)"
                        }
                      
                    }

                }
                               
            }
            

       }
    }
    @objc func deneme() {
        
    }
}
