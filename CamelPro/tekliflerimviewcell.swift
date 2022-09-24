//
//  tekliflerimviewcell.swift
//  CamelPro
//
//  Created by Can Kirac on 6.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
class tekliflerimviewcell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.real.isHidden = false

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var l1: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    var idsi = ""
    @IBOutlet weak var kalkis: UILabel!
    @IBOutlet weak var fiyat: UILabel!
    @IBOutlet weak var varis: UILabel!
    
    @IBOutlet weak var l4: UIButton!
    @IBOutlet weak var l3: UIButton!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var onayview: UIView!
    
    @IBOutlet weak var real: UIView!
    @IBAction func hayir(_ sender: Any) {
        
        onayview.isOpaque = true
        onayview.backgroundColor = UIColor.clear
        l1.backgroundColor = UIColor.clear
        l2.backgroundColor = UIColor.clear
        l3.backgroundColor = UIColor.clear
        l4.backgroundColor = UIColor.clear


        onayview.isHidden = true
    }
    @IBAction func sil(_ sender: Any) {
        onayview.backgroundColor = UIColor.white
        l3.backgroundColor = UIColor.systemGray
        l4.backgroundColor = UIColor.black
        onayview.isHidden = false
        
        
    }
    
    
    @IBAction func evet(_ sender: Any) {
        let db = Firestore.firestore()
        db.collection("icerik_basvuru").document(idsi).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.onayview.isOpaque = true
                self.onayview.backgroundColor = UIColor.clear
                self.l1.backgroundColor = UIColor.clear
                self.l2.backgroundColor = UIColor.clear
                self.l3.backgroundColor = UIColor.clear
                self.l4.backgroundColor = UIColor.clear
                self.real.isHidden = true
            }
    }
    
    }
}
