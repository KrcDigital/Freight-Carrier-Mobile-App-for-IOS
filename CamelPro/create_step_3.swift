//
//  create_step_3.swift
//  CamelPro
//
//  Created by Can Kirac on 20.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
class create_step_3: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    var araccesit = ["Hepsi","Tenteli Tır(13,60)","Treyler Tır","Açık Tır(13,60)","Lowbed Tır","Frigo Tır","Tanker Tır","Havuz Tipi Damperli Tır","Sal Kasa Tır","Flat Rack Tır","Kısa Dorse Tır","Kapalı Kasa Tır","Kırkayak","Frigo Kamyon","Havuz Damperli Kamyon","Açık Kasa Kamyon","Açık Kasa Damperli Kamyon","Brandalı Kamyon","Kurtarıcı Kamyon","Flat Rack Kamyon"]
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return araccesit.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return araccesit[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_arac = araccesit[row]
    }

    @IBOutlet weak var aracs: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        aracs.delegate = self
        aracs.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
        print("buradadeger2\(self.yerboylammk)")

        // Initialization code
    }
  
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBOutlet weak var detay: UITextView!
    
    @IBOutlet weak var ucret: UITextField!
    
    var kalkis_yeri = ""
    var varis_yeri = ""
var selected_arac = "Hepsi"
    
    @IBOutlet weak var uyari: UILabel!
    
    var namee = ""
    
    @IBAction func next(_ sender: Any) {
        if self.detay.text == "" {
            self.uyari.textColor = UIColor.red
        }
        else {
            performSegue(withIdentifier: "next", sender: nil)

        }
    }
    
    var yerenlemmk = Double()
    var yerboylammk = Double()
    var yerenlemmv = Double()
    var yerboylammv = Double()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! create_step_4
        destinationVc.kalkis_yeri = kalkis_yeri
        destinationVc.varis_yeri = varis_yeri
        destinationVc.detay = detay.text
        destinationVc.ucret = ucret.text as! String
        destinationVc.araccesit = selected_arac
        destinationVc.yerboylamv = yerboylammv
        destinationVc.yerenlemv = yerenlemmv
        destinationVc.yerboylamk = yerboylammk
        destinationVc.yerenlemk = yerenlemmk

    }
    
    @IBAction func geri(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
