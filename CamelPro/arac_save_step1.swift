//
//  arac_save_step1.swift
//  CamelPro
//
//  Created by Can Kirac on 21.05.2022.
//

import UIKit

class arac_save_step1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
        // Initialization code
    }
    

    @IBOutlet weak var p1: UITextField!
    @IBOutlet weak var p2: UITextField!
    
    @IBOutlet weak var p3: UITextField!
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBOutlet weak var plaka: UITextField!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! arac_save_step2
        destinationVC.plaka = "\(p1.text!) \(p2.text!) \(p3.text!)"
    }

}
