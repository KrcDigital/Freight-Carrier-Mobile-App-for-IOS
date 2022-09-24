//
//  user_yorumcell.swift
//  CamelPro
//
//  Created by Can Kirac on 12.06.2022.
//

import UIKit

class user_yorumcell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var textt: UITextView!
    @IBOutlet weak var puan: UILabel!
    
    @IBOutlet weak var imgg: UIImageView!
    
}
