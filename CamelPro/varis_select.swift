//
//  varis_select.swift
//  CamelPro
//
//  Created by Can Kirac on 11.06.2022.
//

import UIKit
import MapKit
import CoreLocation

class varis_select: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mapview.delegate = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(choseloc))
        
        gesture.minimumPressDuration = 2
        mapview.addGestureRecognizer(gesture)
        
        print("buradadeger\(self.yerboylamm)")
        // Do any additional setup after loading the view.
    }
    
    @objc func choseloc(gesture:UILongPressGestureRecognizer) {
        
        if gesture.state == .began {
            let touchpoint = gesture.location(in: self.mapview)
            let touchcoor = self.mapview.convert(touchpoint, toCoordinateFrom: self.mapview)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchcoor
            annotation.title = "Varış"
            self.mapview.addAnnotation(annotation)
            
            self.yerenlemv = touchcoor.latitude
            self.yerboylamv = touchcoor.longitude
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapview.setRegion(region, animated: true)
        
    }
    
    var yerenlemv = Double()
    var yerboylamv = Double()

    @IBAction func nextstep(_ sender: Any) {
        if !yerenlemv.isZero {
   
        performSegue(withIdentifier: "nextstep", sender: nil)
            
        }
        else {
            self.uyari.textColor = UIColor.red
        }
    }
    
    var namee = ""
    
    var selected_kalkis = ""
    var isveren_id = ""
    var selected_sehir = ""
    var yerenlemm = Double()
    var yerboylamm = Double()
    
    @IBOutlet weak var uyari: UILabel!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! create_step_3
        destinationVc.kalkis_yeri = selected_kalkis
        destinationVc.varis_yeri = selected_sehir
        destinationVc.namee = namee
        destinationVc.yerenlemmk = yerenlemm
        destinationVc.yerboylammk = yerboylamm
        destinationVc.yerenlemmv = yerenlemv
        destinationVc.yerboylammv = yerboylamv
        
    }
    
    @IBAction func geri(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
    

}
