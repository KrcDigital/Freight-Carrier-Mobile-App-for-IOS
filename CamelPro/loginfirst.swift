//
//  loginfirst.swift
//  CamelPro
//
//  Created by Can Kirac on 30.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
class loginfirst: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func anons(_ sender: Any) {
        
        Auth.auth().signInAnonymously() { (user, error) in
            if let aUser = user {
                    //Do something cool!
                self.performSegue(withIdentifier: "tomainn2", sender: nil)
            }
        }
    }
    

}
