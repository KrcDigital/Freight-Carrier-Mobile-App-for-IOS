//
//  user_kayit.swift
//  CamelPro
//
//  Created by Can Kirac on 18.05.2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Foundation
import WebKit
import SDWebImage


class user_kayit: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var sehirler = ["Adana", "Adıyaman", "Afyon", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin",
                    "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale",
                    "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir",
                    "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta", "Mersin", "İstanbul", "İzmir",
                    "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya",
                    "Manisa", "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya",
                    "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak",
                    "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak",
                    "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"]
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sehirler.count
    }

    @IBOutlet weak var pickme: UIPickerView!
    
    @IBAction func sozles(_ sender: Any) {
        performSegue(withIdentifier: "sozlesme", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user_img.isUserInteractionEnabled = true
        let sendimg_msj = UITapGestureRecognizer(target: self, action: #selector(sendimgmesaj))
        user_img.addGestureRecognizer(sendimg_msj)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        pickme.delegate = self
        pickme.dataSource = self
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
        laydoutSubviews()
        // Initialization code
    }
    
    @objc func laydoutSubviews() {
        user_img.layer.masksToBounds = true
            user_img.layer.cornerRadius = user_img.bounds.width / 2        }
    
    @IBOutlet weak var imgsec: UIImageView!
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBOutlet weak var user_img: UIImageView!
    @IBOutlet weak var user_meslekiyas: UITextField!
    @IBOutlet weak var user_lastname: UITextField!
    @IBOutlet weak var user_name: UITextField!
    
    var picker = UIImagePickerController();

    @objc func sendimgmesaj() {
       pickImage(self){ image in
                //here is the image
            }
    }
    var pickImageCallback : ((UIImage) -> ())?;
    var viewController: UIViewController?
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        

        func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
            pickImageCallback = callback;
            self.viewController = viewController;

            alert.popoverPresentationController?.sourceView = self.viewController!.view

            viewController.present(alert, animated: true, completion: nil)
        }
        func openCamera(){
            alert.dismiss(animated: true, completion: nil)
            if(UIImagePickerController .isSourceTypeAvailable(.camera)){
                picker.sourceType = .camera
                self.viewController!.present(picker, animated: true, completion: nil)
            } else {
                let alertController: UIAlertController = {
                    let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default)
                    controller.addAction(action)
                    return controller
                }()
                viewController?.present(alertController, animated: true)
            }
        }
        func openGallery(){
            alert.dismiss(animated: true, completion: nil)
            picker.sourceType = .photoLibrary
            self.viewController!.present(picker, animated: true, completion: nil)
        }
    
      
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    var user_img_name = ""
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         
           user_img.image = info [.originalImage] as? UIImage
                    self.dismiss(animated: true, completion: nil)
                    user_img_name = "\(randomString(length: 9)).jpg"
                    let storage = Storage.storage()
                    let reff = storage.reference()
                    let mediafolder = reff.child("user_profil_img")
                    if let data = user_img.image?.jpegData(compressionQuality: 0.3){
                        let imgref = mediafolder.child(user_img_name)
                        imgref.putData(data, metadata: nil) { metadata, error in
                            if error != nil {
                                print("error")
                            }
                            else {
                                imgref.downloadURL { [self] url, error in
                                    if error == nil {
            
            
            
                                        
            
            
            
            
                                    }
                            }
                        }
                    }
                }
            
            
            
        }



    

    
    var chosenimgurl = ""
    var chosenimglbl = ""

    @IBAction func img_SEc(_ sender: Any) {
       
        pickImage(self){ image in
                 //here is the image
             }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sehirler[row]
    }
    
    
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    @objc func cratt() {
        let storage = Storage.storage()
        let reff = storage.reference()
        let mediafolder = reff.child("user_profil_img")
        if let data = user_img.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imgref = mediafolder.child("\(uuid).jpg")
            imgref.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    print("error \(error)")
                }
                else {
                    imgref.downloadURL { [self] url, error in
                        if error == nil {
                            let imageurl = url?.absoluteString
                            
                            
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.photoURL = url
                            changeRequest?.displayName = "\(user_name.text as! String) \(user_lastname.text as! String)"
                            
                            changeRequest?.commitChanges { error in
                              // ...
                            }
                            
                            
                            
                            
                            let firestore = Firestore.firestore()
                            let firestorepacket = ["isim":self.user_name.text!,"soyisim":self.user_lastname.text!,"mesleki_yas":self.user_meslekiyas.text,"user_img":imageurl!,"user_id":Auth.auth().currentUser?.uid,"uyelik":uyelik_cesit,"jeton":0,"numara":Auth.auth().currentUser?.phoneNumber!,"star":"5","tamamlanantutar":0,"aktiftutar":0] as [String : Any]
                            
                            var firestoreref : DocumentReference?
                            firestoreref = firestore.collection("users").addDocument(data: firestorepacket, completion: { error in
                                if error != nil {
                                    print("hata aldın")
                                }
                                else {
                                    self.createbildirim()
                                    print("hata aldın2")

                                    let alert = UIAlertController(title: "Başarılı", message: "Üyelik işleminiz başarıyla gerçekleşti.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
                                        switch action.style{
                                            case .default:
                                            performSegue(withIdentifier: "geri", sender: nil)

                                            print("i")
                                            
                                        case .cancel:
                                            performSegue(withIdentifier: "geri", sender: nil)

                                            print("i")

                                        case .destructive:
                                            performSegue(withIdentifier: "geri", sender: nil)

                                            print("i")

                                        @unknown default:
                                            print("i")

                                        }
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                    
                                    
                                }
                            })
                        }
                }
            }
        }
    }
    }
    
    var uyelikstr = "Nakliyeci"
    
    @IBAction func create(_ sender: UIButton) {
    
        
        
        
        let alert = UIAlertController(title: "Onay", message: "\(uyelikstr) Profili oluşturuyorsunuz onaylıyor musunuz ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { action in
            switch action.style{
                case .default:
                self.cratt()
                print("i")
                
            case .cancel:

                print("i")

            case .destructive:

                print("i")

            @unknown default:
                print("i")

            }
        }))
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
        
        
    }
    @IBOutlet weak var createout: UIButton!
    
    @IBOutlet weak var fotografiniz: UILabel!
    @IBAction func `switch`(_ sender: UISwitch) {
        if (sender.isOn){
            createout.isEnabled = true
        }
        else{
            createout.isEnabled = false

        }
    
    }
    @IBOutlet weak var isiml: UILabel!
    
    @IBOutlet weak var soyis: UIStackView!
    @IBOutlet weak var belge: UIStackView!
    @IBOutlet weak var meslekii: UIStackView!
    @IBOutlet weak var meslekl: UILabel!
    @IBOutlet weak var soyisiml: UILabel!
    var uyelik_cesit = "0"
    
    @IBOutlet weak var lokasyon: UIStackView!
    @IBAction func add_segment_change(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0:
            uyelikstr = "Nakliyeci"
            uyelik_cesit = "0"
            fotografiniz.text = "Fotoğrafınız:"
            user_img.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/camelpro-6cbbc.appspot.com/o/resim_2022-05-30_201020029.png?alt=media&token=de00162f-e049-4029-ac95-01f381371899"))
            isiml.text = "İsim"
            meslekii.isHidden = false
            lokasyon.isHidden = true
            soyisiml.text = "Soyisim"
            meslekl.text = "Mesleki Yaş"
            belge.isHidden = false
            soyis.isHidden = false

            case 1:
            uyelikstr = "İşveren"

            isiml.text = "Firma Adı"
            soyisiml.text = "Firma Lokasyon"
            meslekii.isHidden = true
            lokasyon.isHidden = false
            belge.isHidden = true
            soyis.isHidden = true
            uyelik_cesit = "1"
            fotografiniz.text = "Logonuz:"
            user_img.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/camelpro-6cbbc.appspot.com/o/iconlast-1024.png?alt=media&token=6b64f5c2-4b2c-4248-a416-c90ca6dae1d0"))
            

        default:
            uyelikstr = "Nakliyeci"

            uyelik_cesit = "0"
            fotografiniz.text = "Fotoğrafınız:"
            user_img.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/camelpro-6cbbc.appspot.com/o/resim_2022-05-30_201020029.png?alt=media&token=de00162f-e049-4029-ac95-01f381371899"))
            isiml.text = "İsim"
            meslekii.isHidden = false
            lokasyon.isHidden = true
            soyisiml.text = "Soyisim"
            meslekl.text = "Mesleki Yaş"
            belge.isHidden = false
            soyis.isHidden = false                   }
        
    }
    
    
    @IBAction func createbildirim() {
        
       
                            
                            let firestore = Firestore.firestore()
        let firestorepacket = ["sahip": Auth.auth().currentUser?.uid,"baslik":"Üyelik","text":"Üyeliğiniz tamamlanmıştır."] as [String : Any]
                            
                            var firestoreref : DocumentReference?
                            firestoreref = firestore.collection("bildirim").addDocument(data: firestorepacket, completion: { error in
                                if error != nil {
                                    print("hata aldın")
                                }
                                else {


                                }
                            })
                        }
                
      

}
