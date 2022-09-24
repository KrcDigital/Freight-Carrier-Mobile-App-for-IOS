//
//  is_haritam.swift
//  CamelPro
//
//  Created by Can Kirac on 12.06.2022.
//

import UIKit
import MapKit
import CoreLocation

class is_haritam: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        let annotation = MKPointAnnotation()
        annotation.title = titlem
        let cordi = CLLocationCoordinate2D(latitude: long, longitude: lati)
        
        annotation.coordinate = cordi
        mapp(mapp, viewFor: annotation)
        
        mapp.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: cordi, span: span)
        
        mapp.setRegion(region, animated: true)
        mapp.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    var titlem = ""
    var lati = Double()
    var long = Double()
    
  
    
    
    func mapp(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
//        if annotation is MKUserLocation {
//            return nil
//        }
        
        let refid = "myant"
        
        var pinview = mapView.dequeueReusableAnnotationView(withIdentifier: refid) as? MKPinAnnotationView
        
        if pinview == nil {
            pinview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: refid)
            pinview?.canShowCallout = true
            pinview?.tintColor = UIColor.black
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinview?.rightCalloutAccessoryView = button
        }
        
        else {
            pinview?.annotation = annotation
        }
        
        return pinview
        
    }
    
    @IBAction func tarif(_ sender: Any) {
        
        let clloc = CLLocation(latitude: long, longitude: lati)
        CLGeocoder().reverseGeocodeLocation(clloc) { placemarks, error in
            if placemarks!.count > 0 {
                
                let newpl = MKPlacemark(placemark: placemarks![0])
                let item = MKMapItem(placemark: newpl)
                item.name = self.titlem
                let laouc = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                item.openInMaps(launchOptions: laouc)
                
                
            }
        }

    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let clloc = CLLocation(latitude: long, longitude: lati)
        CLGeocoder().reverseGeocodeLocation(clloc) { placemarks, error in
            if placemarks!.count > 0 {
                
                let newpl = MKPlacemark(placemark: placemarks![0])
                let item = MKMapItem(placemark: newpl)
                item.name = "self.titlem"
                let laouc = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                item.openInMaps(launchOptions: laouc)
                
                
            }
        }
        
    }
    
    @IBOutlet weak var mapp: MKMapView!
    
    @IBAction func geri(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }

}
