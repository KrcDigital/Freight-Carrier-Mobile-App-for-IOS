//
//  ilanlar_cell.swift
//  CamelPro
//
//  Created by Can Kirac on 18.05.2022.
//

import UIKit
import MapKit
import CoreLocation

class ilanlar_cell: UITableViewCell, MKMapViewDelegate , CLLocationManagerDelegate  {

    override func awakeFromNib() {
        super.awakeFromNib()

       
    }
    
   

    @IBOutlet weak var arkaplan: UIImageView!
    @IBOutlet weak var yukdo: UIStackView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var kalkis: UILabel!
    
    @IBOutlet weak var krmslmi: UIButton!
    @IBAction func kurumsalmi(_ sender: Any) {
    }
    @IBOutlet weak var odeme_dogrulandi: UILabel!
    @IBOutlet weak var sirket_img: UIImageView!
    @IBOutlet weak var varis: UILabel!
}
