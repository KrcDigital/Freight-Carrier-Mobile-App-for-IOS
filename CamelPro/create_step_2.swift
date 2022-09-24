//
//  create_step_2.swift
//  CamelPro
//
//  Created by Can Kirac on 20.05.2022.
//

import UIKit

class create_step_2: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        varis_picker.delegate = self
        varis_picker.dataSource = self
        // Do any additional setup after loading the view.
        print("buradadeger2\(self.kalkis_boy)")

    }
    
    var selected_kalkis = ""
    var isveren_id = ""
var namee = ""
    
    @IBOutlet weak var varis_picker: UIPickerView!
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sehirler[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_sehir = sehirler[row]
    }
    var selected_sehir = "Adana"

    var kalkis_en = Double()
    var kalkis_boy = Double()
    
    
    @IBAction func nextstep(_ sender: Any) {
        performSegue(withIdentifier: "nextstep", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! create_step_3
        

        destinationVc.kalkis_yeri = selected_kalkis
        destinationVc.varis_yeri = selected_sehir
        destinationVc.namee = namee
        destinationVc.yerenlemmk = kalkis_en
        destinationVc.yerboylammk = kalkis_boy
        destinationVc.yerenlemmv = 0
        destinationVc.yerboylammv = 0
        
    }
    
    
    @IBAction func geri(_ sender: Any) {
        
            
            self.navigationController?.popViewController(animated: true)

            self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
