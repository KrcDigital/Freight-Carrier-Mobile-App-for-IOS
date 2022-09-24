//
//  buy_coin.swift
//  CamelPro
//
//  Created by Can Kirac on 25.05.2022.
//

import UIKit
import PassKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


class buy_coin: UIViewController, PKPaymentAuthorizationViewControllerDelegate,UITableViewDelegate, UITableViewDataSource {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true , completion: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiyats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fiyattable.dequeueReusableCell(withIdentifier: "fiyatcell", for: indexPath) as! buycoin_cell
        cell.fiyat.setTitle("\(fiyats[indexPath.row]) TL", for: .normal)
        cell.baslik.text = "Teklif Jetonu (\(adets[indexPath.row])x)"
        
        
        
        return cell
        
    }
    
    var fiyats = [Int]()
    var imgs = [String]()
    var adets = [String]()
    
    func getfiyat() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("fiyat_tarife").order(by: "fiyat").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.fiyats.removeAll()
                    self.adets.removeAll()
                    self.imgs.removeAll()
                    
                    for doc in  snapshot!.documents {
                        
                            let docId = doc.documentID
                            if let fiyat = doc.get("fiyat") as? Int {
                                
                                self.fiyats.append(fiyat)
                                self.adets.append(doc.get("adet") as! String)
                            }
 
                        
                    }

                }
            }
            self.fiyattable.delegate = self
            self.fiyattable.dataSource = self
            self.fiyattable.reloadData()
            
            
            
        
        }
    }
    
    @IBAction func geri(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var fiyattable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getfiyat()
        // Do any additional setup after loading the view.
    }
    
    
    private var paymentRequest : PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.fatiher.camelpro"
        request.supportedNetworks = [.quicPay, .masterCard ,.visa]
        request.countryCode = "TR"
                request.currencyCode = "TRY"
        request.merchantCapabilities = .capability3DS
        
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Deneme", amount: 1)]
        return request
    }()

    @IBAction func addco(_ sender: Any) {
        
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        if controller != nil {
            controller!.delegate = self
            present(controller!, animated: true) {
                print("Complateedd")
            }
        }
        
        
    }
   
}

extension ViewController : PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true , completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
}
