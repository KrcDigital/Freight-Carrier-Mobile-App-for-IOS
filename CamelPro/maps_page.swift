//
//  maps_page.swift
//  CamelPro
//
//  Created by Can Kirac on 11.06.2022.
//

import UIKit
import MapKit
import CoreLocation

class maps_page: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{

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
        
        gesture.minimumPressDuration = 3
        mapview.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func choseloc(gesture:UILongPressGestureRecognizer) {
        
        if gesture.state == .began {
            let touchpoint = gesture.location(in: self.mapview)
            let touchcoor = self.mapview.convert(touchpoint, toCoordinateFrom: self.mapview)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchcoor
            annotation.title = "Kalkış"
            self.mapview.addAnnotation(annotation)
            
            self.yerenlem = touchcoor.latitude
            self.yerboylam = touchcoor.longitude
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapview.setRegion(region, animated: true)
        
    }
    @IBOutlet weak var uyari: UILabel!
    
    var yerenlem = Double()
    var yerboylam = Double()

    @IBAction func nextstep(_ sender: Any) {
        if !yerenlem.isZero {
   
        performSegue(withIdentifier: "nextstep", sender: nil)
            
        }
        else {
            self.uyari.textColor = UIColor.red
        }
    }
    
    var namee = ""
    
    var selected_kalkis = ""
    var isveren_id = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination as! create_step_2
        destinationvc.isveren_id = isveren_id
        destinationvc.namee = namee
        destinationvc.selected_kalkis = selected_kalkis
        destinationvc.kalkis_en = yerenlem
        destinationvc.kalkis_boy = yerboylam
        
    }
    
    
    @IBAction func geri(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }

}
