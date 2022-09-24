//
//  tarih_selectmain.swift
//  CamelPro
//
//  Created by Can Kirac on 19.06.2022.
//

import UIKit

class tarih_selectmain: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func dater(_ sender: Any) {
        
        
    }
    
    @IBOutlet weak var datetarihim: UIDatePicker!
    var selectedtarih = ""
    
    
    @IBAction func goma(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedtarih = dateFormatter.string(from: datetarihim.date)
        
        performSegue(withIdentifier: "goma", sender: nil)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goma" {
            let dest = segue.destination as! ViewController
            dest.tarih_secildimi = 1
            dest.selected_tarih = selectedtarih
            dest.tarih_secildi(tarihhh : selectedtarih)
        }
    }
    
    
}
