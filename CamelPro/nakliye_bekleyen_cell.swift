//
//  nakliye_bekleyen_cell.swift
//  CamelPro
//
//  Created by Can Kirac on 5.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
class nakliye_bekleyen_cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func git(_ sender: Any) {
        let nak = nakliyeci_bekleyen()
        nak.chosenisid = idsi
        
        
    }
    @IBOutlet weak var l4: UIButton!
    @IBOutlet weak var l3: UIButton!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var onayview: UIView!
    var idsi = ""
    @IBOutlet weak var real: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var kalkis: UILabel!
    
    @IBAction func evt(_ sender: Any) {
        
        
      
    }
    @IBAction func hyr(_ sender: Any) {
        onayview.isOpaque = true
        onayview.backgroundColor = UIColor.clear
        l1.backgroundColor = UIColor.clear
        l2.backgroundColor = UIColor.clear
        l3.backgroundColor = UIColor.clear
        l4.backgroundColor = UIColor.clear


        onayview.isHidden = true
    }
    @IBOutlet weak var varis: UILabel!
    
    @IBAction func sil(_ sender: Any) {
        onayview.backgroundColor = UIColor.white
        l3.backgroundColor = UIColor.systemGray
        l4.backgroundColor = UIColor.black
        onayview.isHidden = false
        
        
    }
    
    
}
