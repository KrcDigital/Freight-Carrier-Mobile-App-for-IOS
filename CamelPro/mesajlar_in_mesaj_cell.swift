//
//  mesajlar_in_mesaj_cell.swift
//  CamelPro
//
//  Created by Can Kirac on 18.05.2022.
//

import UIKit

class mesajlar_in_mesaj_cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var msjlabel: UILabel!
    
    @IBOutlet weak var yourdate: UILabel!
    @IBOutlet weak var mytarih: UILabel!
    @IBOutlet weak var mymsj: UILabel!
    @IBOutlet weak var youmsj: UILabel!
    @IBOutlet weak var myimg: UIImageView!
    @IBOutlet weak var otherimg: UIImageView!
}
