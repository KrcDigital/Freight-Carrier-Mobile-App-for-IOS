//
//  controlpageone.swift
//  CamelPro
//
//  Created by Can Kirac on 5.06.2022.
//

import UIKit

class controlpageone: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tokullanici.isUserInteractionEnabled = true
        tokullanicitwo.isUserInteractionEnabled = true

        let tokullanicii = UIGestureRecognizer(target: self, action: #selector(touser))
        tokullanici.addGestureRecognizer(tokullanicii)
        tokullanicitwo.addGestureRecognizer(tokullanicii)

        
        towork.isUserInteractionEnabled = true
        let toworks = UIGestureRecognizer(target: self, action: #selector(touser))
        towork.addGestureRecognizer(toworks)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tokullanici: UIView!
    
    @objc func touser() {
        performSegue(withIdentifier: "touser", sender: nil)
    }
   
    @IBOutlet weak var tokullanicitwo: UIImageView!
    @IBOutlet weak var towork: UIView!
}
