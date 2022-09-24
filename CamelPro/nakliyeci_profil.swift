//
//  nakliyeci_profil.swift
//  CamelPro
//
//  Created by Can Kirac on 18.05.2022.
//

import UIKit
import PieCharts
import Firebase
import FirebaseAuth
import FirebaseFirestore

class nakliyeci_profil: UIViewController ,PieChartDelegate{
    func onSelected(slice: PieSlice, selected: Bool) {
        print("Selected: \(selected), slice: \(slice)")
    }
    
    @IBOutlet weak var gojeton: UIView!
    
    @IBOutlet weak var jetonadet: UILabel!
    @IBOutlet weak var chartView: PieChart!
    override func viewDidAppear(_ animated: Bool) {
        
        chartView.layers = [createCustomViewsLayer(), createTextLayer()]
        chartView.delegate = self
        chartView.models = createModels() // order is important - models have to be set at the end
    }

    fileprivate func createCustomViewsLayer() -> PieCustomViewsLayer {
        let viewLayer = PieCustomViewsLayer()
        
        let settings = PieCustomViewsLayerSettings()
        settings.viewRadius = 135
        settings.hideOnOverflow = false
        viewLayer.settings = settings
        
        viewLayer.viewGenerator = createViewGenerator()
        
        return viewLayer
    }
    
    fileprivate func createTextLayer() -> PiePlainTextLayer {
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 60
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 16)
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
        }
        
        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
    }
    
    fileprivate func createModels() -> [PieSliceModel] {
        let alpha: CGFloat = 0.5
        
        return [
            PieSliceModel(value: Double(self.taml), color: hexStringToUIColor(hex: "#A8A8AB")),
            PieSliceModel(value: Double(self.akl), color: hexStringToUIColor(hex: "#5D5B5D")),
            //PieSliceModel(value: 0, color: hexStringToUIColor(hex: "#D0D2D5"))
        ]
    }
    

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBOutlet weak var tojetonimg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tamamlanantutar = 0
        aktiftutar = 0
        
        
        let tojeton = UITapGestureRecognizer(target: self, action: #selector(gotojeton))
        
        tojetonimg.isUserInteractionEnabled = true
        tojetonimg.addGestureRecognizer(tojeton)
        
        tojetonlbl.isUserInteractionEnabled = true
        tojetonlbl.addGestureRecognizer(tojeton)
        getaracs()
        getuserbilgi()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tojetonlbl: UILabel!
    
    @objc func gotojeton() {
        print("bass")
        performSegue(withIdentifier: "tobuyjeton", sender: nil)
    }
    
    var plakalar = [String]()
    var imgs = [String]()
    var durumlar = [Int]()
    var ids = [String]()
    var marka = [String]()
    var model = [String]()
    
    var tamamlanantutar = 0
    var aktiftutar = 0
    
    var taml = 1
    var akl = 1
    
    @objc func getuserbilgi() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("users").whereField("user_id", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                                
                            self.jetonadet.text = "\(doc.get("jeton") as! Int) Teklif Jetonu"
                            if (doc.get("tamamlanantutar") as! Int) > 0 {
                                self.tamamlanantutar = doc.get("tamamlanantutar") as! Int
                                self.taml = doc.get("tamamlanantutar") as! Int

                            }
                            
                            
                            if (doc.get("aktiftutar") as! Int) > 0 {
                                self.aktiftutar = doc.get("aktiftutar") as! Int
                                self.akl = doc.get("aktiftutar") as! Int

                            }
                            
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }

        }
        

    }
    @IBOutlet weak var trsh: UIButton!
    @objc func getaracs() {
        
        

        let firestoredb = Firestore.firestore()
        
        
        firestoredb.collection("araclar").whereField("sahip", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
                
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.plakalar.removeAll()
                    self.imgs.removeAll()
                    self.durumlar.removeAll()
                    self.ids.removeAll()
                    self.model.removeAll()
                    self.marka.removeAll()
                   
                    for doc in  snapshot!.documents {
                        if let kontrol = doc.documentID as? String {
                            
                            self.trsh.isHidden = false
                                
                            self.ids.append(doc.documentID as! String)
                            self.plakalar.append(doc.get("plaka") as! String)
                           self.durumlar.append(doc.get("durum") as! Int)
                            self.imgs.append(doc.get("img") as! String)
                            self.marka.append(doc.get("marka") as! String)
                            self.model.append(doc.get("model") as! String)
                            
                        }
                        
                        
                        
                    }

                }
                
                
            }
            
            self.aracgoster()
            
            

        }
        

    }
    @IBOutlet weak var arabaimgsi: UIImageView!
    
    @IBAction func backarac(_ sender: Any) {
        if yer > 0 {
            yer = yer - 1
            aracgoster()
        }
        
    }
    @IBAction func nextarac(_ sender: Any) {
        if yer < plakalar.count {
            yer = yer + 1
            aracgoster()
        }
        
    }
    var yer = 0
    @IBOutlet weak var araba_model: UILabel!
    @IBOutlet weak var aracsayisi: UILabel!
    @objc func aracgoster() {
        
        if plakalar.count > yer {

        aracsayisi.text = "Araçlarım(\(plakalar.count))"
        araba_model.text = "Marka: \(marka[yer]) - Model: \(model[yer]) "
        arabaimgsi.sd_setImage(with: URL(string: imgs[yer]))
            
        }
        
        
        
    }
    
    
    fileprivate func createViewGenerator() -> (PieSlice, CGPoint) -> UIView {
        return {slice, center in
            
            let container = UIView()
            container.frame.size = CGSize(width: 250, height: 40)
            container.center = center
            let view = UIImageView()
            
            view.frame = CGRect(x: 30, y: 0, width: 400, height: 40)
            container.addSubview(view)
            
                let specialTextLabel = UILabel()
                specialTextLabel.textAlignment = .center
                if slice.data.id == 0 {
//                    specialTextLabel.text = "Şehir İçi \(slice.data.model.value) TL"
                    
                    specialTextLabel.text = "Tamamlanan \(self.tamamlanantutar) TL"
                    specialTextLabel.textColor = UIColor.white
                    specialTextLabel.frame = CGRect(x: 0, y: 40, width: 1000, height: 20)

                    specialTextLabel.font = UIFont.boldSystemFont(ofSize: 13)
                }
            if slice.data.id == 2 {
                if slice.data.model.value == 0 {
                    specialTextLabel.text = ""

                }
                else {
                    specialTextLabel.text = "İptal Olan \(slice.data.model.value) TL"
                    specialTextLabel.text = "İptal Olan \(0) TL"

                }
                specialTextLabel.textColor = UIColor.white
                

                specialTextLabel.font = UIFont.boldSystemFont(ofSize: 15)
            }
                if slice.data.id == 1 {
                    specialTextLabel.textColor = UIColor.white
                    specialTextLabel.text = "Devam Eden \(slice.data.model.value) TL"
                    specialTextLabel.text = "Devam Eden \(self.aktiftutar) TL"
                    specialTextLabel.font = UIFont.boldSystemFont(ofSize: 18)

                }
                specialTextLabel.sizeToFit()
                specialTextLabel.frame = CGRect(x: 0, y: 40, width: 1000, height: 20)
            specialTextLabel.font = UIFont.boldSystemFont(ofSize: 15)

                container.addSubview(specialTextLabel)
            
                container.frame.size = CGSize(width: 1000, height: 60)
            
            
            
            
            
            
            return container
        }
    }
    @IBOutlet weak var araclbl: UILabel!
    
    
    @IBOutlet weak var akliklbl: UILabel!
    
    @IBAction func exitt(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Onay", message: "Çıkış işlemini onaylıyor musunuz ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { action in
            switch action.style{
                case .default:
                
                
                
                do {
                    try Auth.auth().signOut()
                    self.performSegue(withIdentifier: "outtoin", sender: nil)
                }catch {
                    let alert = UIAlertController.init(title: "Hata ! ", message: "Çıkış yapılamadı lütfen tekrar deneyin.", preferredStyle: UIAlertController.Style.alert)
                    let alertbutton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(alertbutton)
                    self.present(alert, animated: true, completion: nil)
                }
                
            case .cancel:
                
                
                do {
                    try Auth.auth().signOut()
                    self.performSegue(withIdentifier: "outtoin", sender: nil)
                }catch {
                    let alert = UIAlertController.init(title: "Hata ! ", message: "Çıkış yapılamadı lütfen tekrar deneyin.", preferredStyle: UIAlertController.Style.alert)
                    let alertbutton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(alertbutton)
                    self.present(alert, animated: true, completion: nil)
                }

            case .destructive:
                
                
                do {
                    try Auth.auth().signOut()
                    self.performSegue(withIdentifier: "outtoin", sender: nil)
                }catch {
                    let alert = UIAlertController.init(title: "Hata ! ", message: "Çıkış yapılamadı lütfen tekrar deneyin.", preferredStyle: UIAlertController.Style.alert)
                    let alertbutton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(alertbutton)
                    self.present(alert, animated: true, completion: nil)
                }

            @unknown default:
                print("i")

            }
        }))
        alert.addAction(UIAlertAction(title: "Hayır", style: .cancel))
        self.present(alert, animated: true, completion: nil)
        
        
        
        

    }
    
    
    
    
    @IBAction func top(_ sender: Any) {
        performSegue(withIdentifier: "top", sender: nil)
    }
    @IBAction func add_segment_change(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0:
            akliklbl.text = "Aylık"
            case 1:
            akliklbl.text = "3Aylık"
            case 2:
            akliklbl.text = "1Yıllık"
            case 3:
            akliklbl.text = "Tümü"

        default:
            akliklbl.text = "Aylık"
                   }
        
    }
    
    
    @IBAction func islerimm(_ sender: Any) {
        performSegue(withIdentifier: "islerim", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "top" {
            let dest = segue.destination as! profilother
            dest.profid = Auth.auth().currentUser!.uid
        }
       
    }
    
    @IBAction func aracsil(_ sender: Any) {
        
            
            let alert = UIAlertController(title: "Onay", message: "Araç silinecek onaylıyor musunuz?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { action in
                switch action.style{
                    case .default:
                    
                    let db = Firestore.firestore()
                    db.collection("araclar").document(self.ids[self.yer]).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            self.navigationController?.popViewController(animated: true)

                            self.dismiss(animated: true, completion: nil)
                        }
                }
                    
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
    
}
