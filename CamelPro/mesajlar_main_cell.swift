//
//  mesajlar_main_cell.swift
//  CamelPro
//
//  Created by Can Kirac on 23.05.2022.
//

import UIKit

class mesajlar_main_cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        layoutSubviews()
        // Initialization code
    }
    
    @objc func goto() {
        print("buramı 3")
        let theStockHolding = mesajlarim_main()
        let theCost = theStockHolding.deneme()
        theCost
    }
    @objc override func layoutSubviews() {
        user_img.layer.masksToBounds = true
            user_img.layer.cornerRadius = user_img.bounds.width / 2        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("buramı 2")
        // Configure the view for the selected state
    }
    
    @IBOutlet weak var tikla: UIView!
    @IBOutlet weak var user_img: UIImageView!
    var user_id = ""
    @IBOutlet weak var user_name: UILabel!
    
    @IBOutlet weak var last: UITextView!
    
    @IBOutlet weak var date: UILabel!
    
}
