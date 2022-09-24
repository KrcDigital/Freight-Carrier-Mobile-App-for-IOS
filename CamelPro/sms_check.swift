//
//  sms_check.swift
//  CamelPro
//
//  Created by Can Kirac on 17.05.2022.
//

import UIKit
import FirebaseAuth

class sms_check: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    var auth = Auth.auth()

    var currentVerificationId :String?
    @IBOutlet weak var code: UITextField!
    
    @IBAction func smscode(_ sender: Any) {
    }
    @IBAction func check(_ sender: Any) {
        print("aldim\(currentVerificationId!)")
        verifyCode(smsCode: code.text!)
    }
    
    public func verifyCode(smsCode: String) {
//        guard let currentVerificationId = currentVerificationId else {
//            print("girisbasari2")
//
//            return
//        }
//        let credential = PhoneAuthProvider.provider().credential(withVerificationID: currentVerificationId, verificationCode: smsCode)
//
//        auth.signIn(with: credential) { result, error in guard result != nil, error != nil
//
//           // self.code.backgroundColor = UIColor.red
//
//
//
//
//            else {
//            self.performSegue(withIdentifier: "tomain", sender: nil)
//            return
//        }
//
//
//        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: currentVerificationId!, verificationCode: smsCode)

        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            let authError = error as NSError
            print(authError.description)
              self.code.backgroundColor = UIColor.red
            return
          }

          // User has signed in successfully and currentUser object is valid
          let currentUserInstance = Auth.auth().currentUser
                       self.performSegue(withIdentifier: "tomain", sender: nil)

        }
        
        
    }

}
