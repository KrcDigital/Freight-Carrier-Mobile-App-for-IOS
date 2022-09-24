//
//  ViewController.swift
//  CamelPro
//
//  Created by Can Kirac on 16.05.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SDWebImage
import MapKit
import CoreLocation
import OneSignal
import OneSignalCore
import OneSignalOutcomes
import OneSignalExtension
import OneSignalNotificationServiceExtension

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UIPickerViewDelegate, UIPickerViewDataSource , MKMapViewDelegate , CLLocationManagerDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var islerim: UIStackView!
    @IBOutlet weak var filter: UIImageView!
    @IBOutlet weak var towallet: UIStackView!
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sehirler.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sehirler[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_sehir = sehirler[row]
        getdataidler()
        print("bunu sectin \(selected_sehir)")
    }
  

    
    var iceriktarihleri = [String]()
    
    var selected_sehir = "Hepsi"
    let dbase = Firestore.firestore()

    override func viewDidLoad() {
        
        self.aktiflbl.text = "Aktif İşler (0)"
        
        super.viewDidLoad()
        getuserinfo()

        hesabimview.isUserInteractionEnabled = true
        let tohesabim = UITapGestureRecognizer(target: self, action: #selector(gotuhesap))
        hesabimview.addGestureRecognizer(tohesabim)
        getsehirler()
        aktiflbl.text = ""
        
        
        if Auth.auth().currentUser!.isAnonymous {
            tobildirimm.image = UIImage(systemName:  "rectangle.portrait.and.arrow.right")
            tobildirimm.tintColor = UIColor.red

        }
        else {
            tobildirimm.image = UIImage(systemName:  "bell")

        }
        
        islerim.isUserInteractionEnabled = true
        let tois = UITapGestureRecognizer(target: self, action: #selector(islerimto))
        islerim.addGestureRecognizer(tois)
        
        
        tobildirimm.isUserInteractionEnabled = true
        let tobi = UITapGestureRecognizer(target: self, action: #selector(bilto))
        tobildirimm.addGestureRecognizer(tobi)
        
        islertbl.dataSource = self
        islertbl.delegate = self
        
        create_ilan.isUserInteractionEnabled = true
        let create = UITapGestureRecognizer(target: self, action: #selector(tocrate))
        create_ilan.addGestureRecognizer(create)
        
        filter.isUserInteractionEnabled = true
        let filt = UITapGestureRecognizer(target: self, action: #selector(tofilter))
        filter.addGestureRecognizer(filt)
//        towallet.isUserInteractionEnabled = true
//        let tocuzdan = UITapGestureRecognizer(target: self, action: #selector(tocuzdan))
//        towallet.addGestureRecognizer(tocuzdan)
        
        
//        tomesajview.isUserInteractionEnabled = true
//        let tomsj = UITapGestureRecognizer(target: self, action: #selector(tomsj))
//        tomesajview.addGestureRecognizer(tomsj)
        
        layoutSubviews()
    
        onekayit()
        
        
        if tarih_secildimi == 1 {
            
            print("tarih_secildii \(selected_tarih)")
            
        }
        else {
            getdataidler()
        }
        
        
        // Initialization code
    }
    
    @objc func layoutSubviews() {
        profilimg.layer.masksToBounds = true
            profilimg.layer.cornerRadius = profilimg.bounds.width / 2        }
    
    @objc func user_vaarmi() {
        
    }
    
    @objc func islerimto() {
        if Auth.auth().currentUser!.isAnonymous {
            performSegue(withIdentifier: "uyeol", sender: nil)

        }
        else {
        
        if uyelik == "1" {
            performSegue(withIdentifier: "go2sirket", sender: nil)

        }
        if uyelik == "0" {
            performSegue(withIdentifier: "islerim", sender: nil)
        }
            
        }
    }
    
    @objc func tomsj() {
        performSegue(withIdentifier: "tomsj", sender: nil)
        
    }
    @objc func bilto() {
        if Auth.auth().currentUser!.isAnonymous {
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "outtoin", sender: nil)
            }catch {
                let alert = UIAlertController.init(title: "Hata ! ", message: "Çıkış yapılamadı lütfen tekrar deneyin.", preferredStyle: UIAlertController.Style.alert)
                let alertbutton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(alertbutton)
                self.present(alert, animated: true, completion: nil)
            }


        }
        else {
            performSegue(withIdentifier: "bildirim", sender: nil)

        }
        
    }
    @objc func tofilter() {
        performSegue(withIdentifier: "tofilt", sender: nil)
        
    }
    @IBOutlet weak var tomesajview: UIStackView!
    @objc func tocuzdan() {

        performSegue(withIdentifier: "tocuzdan", sender: nil)
        
    }
    @objc func showAlertButtonTapped() {

           

        let alert = UIAlertController(title: "Hata", message: "İlanlar isverenler tarafından oluşturulur.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
            switch action.style{
                case .default:
                
                print("i")
                
            case .cancel:
                print("i")

            case .destructive:
                print("i")

            @unknown default:
                print("i")

            }
        }))
        self.present(alert, animated: true, completion: nil)
        }
    
    @objc func tocrate() {
        if !Auth.auth().currentUser!.isAnonymous {
            if uyelik == "0" {
                showAlertButtonTapped()
            }
            if uyelik == "1" {
                performSegue(withIdentifier: "tocrete", sender: nil)

            }

        }
        else {
            performSegue(withIdentifier: "uyeol", sender: nil)
        }
    }
    
    @IBOutlet weak var create_ilan: UIImageView!
    
    
    
    @objc func gotuhesap() {
        if Auth.auth().currentUser!.isAnonymous {
            performSegue(withIdentifier: "uyeol", sender: nil)

        }
        else {
        if (uyelik == "0") {
            performSegue(withIdentifier: "go2hesap", sender: nil)

        }
        if (uyelik == "1") {
            performSegue(withIdentifier: "go2sirket", sender: nil)

        }
        }
    }
    
    @IBOutlet weak var aktiflbl: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isveren_id.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = islertbl.dequeueReusableCell(withIdentifier: "aktif_cell", for: indexPath) as! ilanlar_cell
        cell.varis.text = varis[indexPath.row]
        cell.kalkis.text = kalkis[indexPath.row]
        cell.sirket_img.sd_setImage(with: URL(string: sirket_img[indexPath.row]))
        cell.arkaplan.image = UIImage(named: kalkis[indexPath.row])
//        cell.mappp!.delegate = self
//
//        let cordi = CLLocationCoordinate2D(latitude: 32.86018241142347, longitude: 39.901759339305535)
//
//        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//
//        let region = MKCoordinateRegion(center: cordi, span: span)
//
//        cell.mappp!.setRegion(region, animated: true)
//        cell.mappp!.delegate = ilanlar_cell()
//
        
//        cell.long = en[indexPath.row]
//        cell.lati = boy[indexPath.row]
        
        
        
        return cell
        
    }
    @IBOutlet weak var hesabimview: UIStackView!
    var uservarmi = 0
    
    
    var tarih_secildimi = 0
    var selected_tarih = ""
    
    var user_id = ""
    var uyelik = ""
    @IBOutlet weak var profilimg: UIImageView!
    var namee = ""
    @objc func getuserinfo() {
        
        if Auth.auth().currentUser!.isAnonymous {
            print("bumune")
        }

        else {
            print("bumune2")

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("user_id", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.uservarmi = 1
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.get("user_id") as? String {
                            
                                let docId = doc.documentID
                            self.user_id = kontrol
                            self.profilimg.sd_setImage(with: URL(string: doc.get("user_img") as! String))
                           self.uyelik = doc.get("uyelik") as! String
                            self.namee = "\(doc.get("isim") as! String) \(doc.get("soyisim") as! String)"
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            if self.uservarmi == 0 {
                self.performSegue(withIdentifier: "userkayit", sender: nil)
            }
            
            else {

            }
            
            if self.uyelik == "1" {
                self.performSegue(withIdentifier: "go2sirket", sender: nil)
            }
            

        }
            
        }

    }
    @IBAction func cikis(_ sender: Any) {
       
    }
    var en = [Double]()
    var boy = [Double]()
    var kalkis = [String]()
    var varis = [String]()
    var kurumsallik = [String]()
    var sirket = [String]()
    var aktif_id = [String]()
    var sirket_img = [String]()
    var tutar = [String]()
    var detay = [String]()
    var isveren_id = [String]()
    var gosterimler = [Int]()
    var phones = [String]()
    var tarihh = [String]()
    var arac = [String]()
    var kilo = [String]()
    var selected_kalkis = ""
    @IBOutlet weak var islertbl: UITableView!
    func getdataidler() {
        
        if selected_sehir != "Hepsi" {
            print("bunu 1")

        let firestoredb = Firestore.firestore()
            self.kalkis.removeAll()
            self.varis.removeAll()
            self.sirket.removeAll()
            self.aktif_id.removeAll()
            self.sirket_img.removeAll()
            self.detay.removeAll()
            self.tutar.removeAll()
            self.isveren_id.removeAll()
            self.phones.removeAll()
            self.tarihh.removeAll()
            self.islertbl.reloadData()
            self.arac.removeAll()
            self.kilo.removeAll()
            self.iceriktarihleri.removeAll()

            firestoredb.collection("icerikler").whereField("kalkis_yeri", isEqualTo: selected_sehir as! String).whereField("durum", isEqualTo:  "0").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.kalkis.removeAll()
                    self.varis.removeAll()
                    self.sirket.removeAll()
                    self.aktif_id.removeAll()
                    self.sirket_img.removeAll()
                    self.detay.removeAll()
                    self.tutar.removeAll()
                    self.isveren_id.removeAll()
                    self.gosterimler.removeAll()
                    self.phones.removeAll()
                    self.en.removeAll()
                    self.tarihh.removeAll()
                    self.boy.removeAll()
                    self.arac.removeAll()
                    self.kilo.removeAll()
                    self.iceriktarihleri.removeAll()

                    for doc in  snapshot!.documents {
                        
                            let docId = doc.documentID
                            if let sirket_id = doc.get("isveren") as? String {
                                self.sirket.append(sirket_id)
                                self.kalkis.append(doc.get("kalkis_yeri") as! String)
                                self.varis.append(doc.get("varis_yeri") as! String)
                                self.aktif_id.append(docId as! String)
                                self.sirket_img.append(doc.get("isveren_img") as! String)
                                self.tutar.append(doc.get("ucret") as! String)
                               self.gosterimler.append(doc.get("gosterim") as! Int)
                                self.detay.append(doc.get("detay") as! String)
                                self.tarihh.append(doc.get("tarih") as! String)
                                self.isveren_id.append(doc.get("isveren_id") as! String)
                                self.phones.append(doc.get("telefon") as! String)
                                self.en.append(doc.get("varisboy") as! Double)
                                self.boy.append(doc.get("varisen") as! Double)
                                self.arac.append(doc.get("araccesit") as! String)
                                self.kilo.append(doc.get("kilo") as! String)
                                // Create Date
                                self.iceriktarihleri.append(doc.get("tarih") as! String)
                            }
 
                        
                    }

                }
            }
            self.aktiflbl.text = "Aktif İşler (\(self.sirket.count))"
            self.islertbl.reloadData()
        
        
        }
            
        }
        
        if selected_sehir == "Hepsi" {

            print("bunu 2")
        let firestoredb = Firestore.firestore()
            self.kalkis.removeAll()
            self.varis.removeAll()
            self.sirket.removeAll()
            self.aktif_id.removeAll()
            self.sirket_img.removeAll()
            self.detay.removeAll()
            self.tutar.removeAll()
            self.isveren_id.removeAll()
            self.islertbl.reloadData()
            self.phones.removeAll()
            self.en.removeAll()
            self.boy.removeAll()
            self.tarihh.removeAll()
            self.iceriktarihleri.removeAll()

            firestoredb.collection("icerikler").whereField("durum", isEqualTo:  "0").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.kalkis.removeAll()
                    self.varis.removeAll()
                    self.sirket.removeAll()
                    self.aktif_id.removeAll()
                    self.sirket_img.removeAll()
                    self.detay.removeAll()
                    self.tutar.removeAll()
                    self.isveren_id.removeAll()
                    self.phones.removeAll()
                    self.tarihh.removeAll()
                    self.iceriktarihleri.removeAll()
                    
                    self.gosterimler.removeAll()
                    for doc in  snapshot!.documents {
                        
                            let docId = doc.documentID
                            if let sirket_id = doc.get("isveren") as? String {
                                self.sirket.append(sirket_id)
                                self.kalkis.append(doc.get("kalkis_yeri") as! String)
                                self.varis.append(doc.get("varis_yeri") as! String)
                                self.aktif_id.append(docId as! String)
                                self.tarihh.append(doc.get("tarih") as! String)
                                self.sirket_img.append(doc.get("isveren_img") as! String)
                                self.tutar.append(doc.get("ucret") as! String)
                            self.gosterimler.append(doc.get("gosterim") as! Int)
                                self.detay.append(doc.get("detay") as! String)
                                
                                self.isveren_id.append(doc.get("isveren_id") as! String)
                                self.phones.append(doc.get("telefon") as! String)
                                self.arac.append(doc.get("araccesit") as! String)
                                self.kilo.append(doc.get("kilo") as! String)
//                                self.en.append(doc.get("varisboy") as! Double)
//                                self.boy.append(doc.get("varisen") as! Double)
                                
                                self.iceriktarihleri.append(doc.get("tarih") as! String)
                                
                            }
 
                        
                    }

                }
            }
            self.aktiflbl.text = "Aktif İşler (\(self.sirket.count))"
            self.islertbl.reloadData()
        
        
        }
            
        }
        
    }
    @IBOutlet weak var tobildirimm: UIImageView!
    
    @IBOutlet weak var kayan: UITextView!
    var sehirler = [String]()
    
    func getsehirler() {
        
        
        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("sehirler").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.sehirler.removeAll()
                    self.sehirler.append("Hepsi")
                    
                    for doc in  snapshot!.documents {
                        
                            let docId = doc.documentID
                            if let sehir = doc.get("sehir") as? String {
                                
                                self.sehirler.append(sehir)
                            }
 
                        
                    }

                }
            }
            self.sehirpicker.dataSource = self
            self.sehirpicker.delegate = self
            
            
            
            
            
        
        }
    }
    @IBOutlet weak var sehirpicker: UIPickerView!
    
    
    var chosenvaris = ""
    var chosenkalkis = ""
    var chosenimg = ""
    var chosensirket = ""
    var chosentutar = ""
    var chosenaktif = ""
    var chosendetay = ""
    var chosengosterim = 0
    var chosenisverenid = ""
    var chosennumber = ""
    var tarihimbe = ""
    var chosenarac = ""
    var chosenkilo = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenaktif = aktif_id[indexPath.row]
        chosenimg = sirket_img[indexPath.row]
        chosenkalkis = kalkis[indexPath.row]
        chosenvaris = varis[indexPath.row]
        chosensirket = sirket[indexPath.row]
        chosentutar = tutar[indexPath.row]
        chosendetay = detay[indexPath.row]
        chosengosterim = gosterimler[indexPath.row]
        chosennumber = phones[indexPath.row]
        chosenisverenid = isveren_id[indexPath.row]
        tarihimbe = tarihh[indexPath.row]
        chosenarac = arac[indexPath.row]
        chosenkilo = kilo[indexPath.row]
        performSegue(withIdentifier: "start", sender: nil)
        
        
    }
    
    var chosenpackrekor = "0"
    var chosensahib = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "start" {
            let destiantionVC = segue.destination as! is_detail_page
            destiantionVC.is_id = chosenaktif
            destiantionVC.varisl = chosenvaris
            destiantionVC.kalkisl = chosenkalkis
            destiantionVC.imgl = chosenimg
            destiantionVC.fiyatl = chosentutar
            destiantionVC.isverenl = chosensirket
            destiantionVC.detaill = chosendetay
            destiantionVC.isveren_id = chosenisverenid
            destiantionVC.gosterim = chosengosterim
            destiantionVC.numberl = chosennumber
            destiantionVC.uyeligim = uyelik
            destiantionVC.kilol = chosenkilo
            destiantionVC.araclbll = chosenarac
            destiantionVC.tarihil = "Taşınma Tarihi :\(tarihimbe)"
            
    }
        if segue.identifier == "go2sirket" {
            let desttwo = segue.destination as! isveren_profil
            desttwo.isverenid = user_id
            desttwo.namee = namee
            
        }
    
}

    
    @objc func tarih_secildi(tarihhh : String) {
        
        print("tarih_bu3")


        let firestoredb = Firestore.firestore()
            self.kalkis.removeAll()
            self.varis.removeAll()
            self.sirket.removeAll()
            self.aktif_id.removeAll()
            self.sirket_img.removeAll()
            self.detay.removeAll()
            self.tutar.removeAll()
            self.isveren_id.removeAll()
            self.phones.removeAll()
            self.tarihh.removeAll()
            self.arac.removeAll()
            self.kilo.removeAll()
            self.iceriktarihleri.removeAll()

            firestoredb.collection("icerikler").whereField("tarih", isEqualTo: tarihhh ).whereField("durum", isEqualTo:  "0").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.kalkis.removeAll()
                    self.varis.removeAll()
                    self.sirket.removeAll()
                    self.aktif_id.removeAll()
                    self.sirket_img.removeAll()
                    self.detay.removeAll()
                    self.tutar.removeAll()
                    self.isveren_id.removeAll()
                    self.gosterimler.removeAll()
                    self.phones.removeAll()
                    self.en.removeAll()
                    self.tarihh.removeAll()
                    self.boy.removeAll()
                    self.arac.removeAll()
                    self.kilo.removeAll()
                    self.iceriktarihleri.removeAll()

                    for doc in  snapshot!.documents {
                        print("tarih_bu ")
                            let docId = doc.documentID
                            if let sirket_id = doc.get("isveren") as? String {
                                self.sirket.append(sirket_id)
                                self.kalkis.append(doc.get("kalkis_yeri") as! String)
                                self.varis.append(doc.get("varis_yeri") as! String)
                                self.aktif_id.append(docId as! String)
                                self.sirket_img.append(doc.get("isveren_img") as! String)
                                self.tutar.append(doc.get("ucret") as! String)
                               self.gosterimler.append(doc.get("gosterim") as! Int)
                                self.detay.append(doc.get("detay") as! String)
                                self.tarihh.append(doc.get("tarih") as! String)
                                self.isveren_id.append(doc.get("isveren_id") as! String)
                                self.phones.append(doc.get("telefon") as! String)
                                self.en.append(doc.get("varisboy") as! Double)
                                self.boy.append(doc.get("varisen") as! Double)
                                self.arac.append(doc.get("araccesit") as! String)
                                self.kilo.append(doc.get("kilo") as! String)
                                // Create Date
                                self.iceriktarihleri.append(doc.get("tarih") as! String)
                                print("tarih_bu2 \(doc.get("tarih") as! String) ")

                            }
 
                        
                    }

                }
            }
            self.aktiflbl.text = "Aktif İşler (\(self.sirket.count))"
            self.islertbl.reloadData()
        
        
        
        }
    }
    
    
    @objc func onekayit() {
        
        
        let deviceState = OneSignal.getDeviceState()
        let userId = deviceState?.userId
            print("OneSignal Push Player ID: ", userId ?? "called too early, not set yet")
        
        if let onenew = userId {
            
            dbase.collection("PlayerId").whereField("numara", isEqualTo:  Auth.auth().currentUser!.phoneNumber).getDocuments { snapshot, error in
                if error != nil {
                    if snapshot?.isEmpty == false && snapshot != nil {
                        for document in snapshot!.documents {
                            if let playimid = document.get("signalid") as? String {
                                
                                if playimid == onenew {
                                    print("esit")
                                }
                                else {
                                    let playerdick = ["numara": Auth.auth().currentUser!.phoneNumber , "signalid" : onenew] as! [String : Any]
                                    
                                    
                                    self.dbase.collection("PlayerId").addDocument(data: playerdick) { error in
                                        if error != nil {
                                            print(error?.localizedDescription)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                    else {
                        let playerdick = ["numara": Auth.auth().currentUser!.phoneNumber , "signalid" : onenew] as! [String : Any]
                        
                        
                        self.dbase.collection("PlayerId").addDocument(data: playerdick) { error in
                            if error != nil {
                                print(error?.localizedDescription)
                            }
                        }
                    }
                }
            }
            
        
        
       
    }
    
    
    
    

    @objc func sendonesig() {
        
        OneSignal.postNotification(["contents": ["tr": "Test Message"], "include_player_ids":["playerid"]])
        
    }
    
    
    
    
    
    
}
