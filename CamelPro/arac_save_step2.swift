//
//  arac_save_step2.swift
//  CamelPro
//
//  Created by Can Kirac on 21.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class arac_save_step2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        user_img.isUserInteractionEnabled = true
        let sendimg_msj = UITapGestureRecognizer(target: self, action: #selector(sendimgmesaj))
        user_img.addGestureRecognizer(sendimg_msj)
        
        let cameraAction = UIAlertAction(title: "Kamera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Galari", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel){
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var btnout: UIButton!
    var picker = UIImagePickerController();

    @IBOutlet weak var user_img: UIImageView!
    var plaka = ""
    var imageurl = ""
    @objc func geturl() {
        btnout.isEnabled = false
        let storage = Storage.storage()
        let reff = storage.reference()
        let mediafolder = reff.child("arac_image")
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
                            self.imageurl = url!.absoluteString
                            print("imgurlburda\(imageurl) \(plaka)")
                            self.btnout.isEnabled = true

                            
    }
                    }
                }
            }
        }
    }

    @objc func sendimgmesaj() {
       pickImage(self){ image in
                //here is the image
            }
    }
    var pickImageCallback : ((UIImage) -> ())?;
    var viewController: UIViewController?
    var alert = UIAlertController(title: "Görsel Seç", message: nil, preferredStyle: .actionSheet)
        

        func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
            pickImageCallback = callback;
            self.viewController = viewController;

            print("buradazaten")
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! arac_save_step3
        print("imgurlburda\(imageurl) \(plaka)")
        destinationVC.plaka = plaka
        destinationVC.imgurl = imageurl
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
       user_img.image = info [.originalImage] as? UIImage
                self.dismiss(animated: true, completion: nil)
        geturl()
    
    }
}
