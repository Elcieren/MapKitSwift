//
//  ViewController.swift
//  Project16
//
//  Created by Eren Elçi on 31.10.2024.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{
    
    @IBOutlet var mapView: MKMapView!
    var locationManger = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(changeMap))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics", wikipediaURL: URL(string: "https://en.wikipedia.org/wiki/London"))
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.25), info: "Founded over a thousand years ago", wikipediaURL: URL(string: "https://en.wikipedia.org/wiki/Oslo"))
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3503), info: "Often called the city of light", wikipediaURL: URL(string: "https://en.wikipedia.org/wiki/Paris"))
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.0, longitude: 12.5), info:"Has a whole country inside it", wikipediaURL: URL(string: "https://en.wikipedia.org/wiki/Rome"))
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself", wikipediaURL: URL(string: "https://en.wikipedia.org/wiki/Washington,_D.C."))

        
        mapView.addAnnotations([london, oslo , paris, rome , washington])
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognizer)
        
    }
    
    @objc func chooseLocation(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == .began {
            // Dokunulan noktayı harita koordinatlarına dönüştürme
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            let coordinates =  self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            
            // Kullanıcıdan başlık ve bilgi almak için alert oluşturma
            let alert = UIAlertController(title: "Yeni Konum Ekle", message: "Başlık ve bilgi girin", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Başlık"
            }
            alert.addTextField { textField in
                textField.placeholder = "Bilgi"
            }
            
            // "Ekle" butonu işlemi
            let addAction = UIAlertAction(title: "Ekle", style: .default) { _ in
                guard let title = alert.textFields?[0].text, !title.isEmpty,
                      let info = alert.textFields?[1].text, !info.isEmpty else {
                    return // Başlık veya bilgi boşsa işlem yapılmaz
                }
                
                let new = Capital(title: title, coordinate: coordinates, info: info , wikipediaURL: URL(string: "https://en.wikipedia.org/wiki/"))
                self.mapView.addAnnotation(new)
            }
            alert.addAction(addAction)
            
            // "İptal" butonu
            alert.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
            
            // Alert'i göster
            present(alert, animated: true)
        }
    }
        
        @objc func changeMap() {
            let alert = UIAlertController(title: "Gorunum", message: "Uydu Gorunumunu seciniz", preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "Standart", style: .default, handler: { action in
                self.mapView.mapType = .standard
            }))
            alert.addAction(UIAlertAction(title: "Uydu", style: .default, handler: { action in
                self.mapView.mapType = .satellite
            }))
            present(alert, animated: true)
        }
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
            guard annotation is Capital  else { return nil }
            let identifier = "Capital"
            var annaotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annaotationView == nil {
                annaotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annaotationView?.canShowCallout = true
                let btn = UIButton(type: .detailDisclosure)
                annaotationView?.rightCalloutAccessoryView = btn
                
            } else {
                annaotationView?.annotation = annotation
            }
            
            annaotationView?.markerTintColor = UIColor.black
            return annaotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let capital = view.annotation as? Capital else { return }
            
            let placename = capital.title
            let placeInfo = capital.info
            
            let ac = UIAlertController(title: placename, message: placeInfo, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Daha Fazla Bilgi icin", style: .default, handler: { [weak self] _ in
                    guard let url = capital.wikipediaURL else { return }
                    let webVC = WebViewController()
                    webVC.url = url
                    self?.navigationController?.pushViewController(webVC, animated: true)
                }))
                ac.addAction(UIAlertAction(title: "İptal", style: .cancel))
                
                present(ac, animated: true)
        }
        
    }
    

