//
//  bildirimcel.swift
//  CamelPro
//
//  Created by Can Kirac on 12.06.2022.
//

import UIKit

class bildirimcel: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var baslik: UILabel!
    
    @IBOutlet weak var bildirim: UILabel!
    
    
}
