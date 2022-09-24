//
//  buycoin_cell.swift
//  CamelPro
//
//  Created by Can Kirac on 27.05.2022.
//

import UIKit

class buycoin_cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var baslik: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var fiyat: UIButton!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
