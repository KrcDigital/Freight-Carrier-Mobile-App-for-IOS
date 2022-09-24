//
//  arac_sec_cell.swift
//  CamelPro
//
//  Created by Can Kirac on 21.05.2022.
//

import UIKit

class arac_sec_cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var plaka: UILabel!
    
    @IBOutlet weak var arac_img: UIImageView!
    
    @IBOutlet weak var durum: UIButton!
    
    var arac_id = ""
    var durumid = 0
}
