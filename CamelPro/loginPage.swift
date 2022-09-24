//
//  loginPage.swift
//  CamelPro
//
//  Created by Can Kirac on 17.05.2022.
//

import UIKit
import FirebaseAuth

class loginPage: UIViewController {

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

    @IBOutlet weak var number: UITextField!
    var currentVerificationId :String?
    
    var auth = Auth.auth()
    
      @IBAction func requestOtp(_ sender: UIButton) {
          
          var temp1 : String! // This is not optional.
          temp1 = number.text
          
        Auth.auth().languageCode = "tr"
          let phoneNumber = "+90\(temp1!)"
        // Step 4: Request SMS
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
          if let error = error {
            print(error.localizedDescription)
              print("burada2 \(error.localizedDescription) \(temp1!)")

            return
          }

          // Either received APNs or user has passed the reCAPTCHA
          // Step 5: Verification ID is saved for later use for verifying OTP with phone number
          self.currentVerificationId = verificationID!
            print("burada \(verificationID!)")
            self.performSegue(withIdentifier: "mobilonay", sender: nil)
        }
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mobilonay" {
            let dest = segue.destination as! sms_check
            dest.currentVerificationId = currentVerificationId
        }
    }
    
    
    @IBAction func gerri(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
}
