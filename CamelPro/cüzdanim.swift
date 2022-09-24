//
//  cüzdanim.swift
//  CamelPro
//
//  Created by Can Kirac on 18.05.2022.
//

import UIKit

class cu_zdanim: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gecmis.dequeueReusableCell(withIdentifier: "odemecell", for: indexPath) as! mesajlar_in_mesaj_cell
        
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        gecmis.dataSource = self
        gecmis.delegate = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func geri(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var gecmis: UITableView!
    
    @IBAction func addnew(_ sender: Any) {
        performSegue(withIdentifier: "addcoin", sender: nil)
    }
}
