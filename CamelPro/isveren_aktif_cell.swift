//
//  isveren_aktif_cell.swift
//  CamelPro
//
//  Created by Can Kirac on 5.06.2022.
//

import UIKit

class isveren_aktif_cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var kalkis: UILabel!
    
    @IBOutlet weak var user_img: UIImageView!
    @IBOutlet weak var user_name: UILabel!
    
    @IBOutlet weak var numara: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var varis: UILabel!
    

}
