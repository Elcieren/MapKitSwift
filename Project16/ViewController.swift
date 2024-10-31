//
//  ViewController.swift
//  Project16
//
//  Created by Eren Elçi on 31.10.2024.
//

import UIKit
import MapKit

class ViewController: UIViewController , MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.25), info: "Founded over a a thousand yerars ago")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3503), info: "Often called the city of light")
        let rome = Capital(title: "Roma", coordinate: CLLocationCoordinate2D(latitude: 41.0, longitude: 12.5), info:"Has a whole country inside it")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after Gerge himself")
        
        mapView.addAnnotations([london, oslo , paris, rome , washington])
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital  else { return nil }
        let identifier = "Capital"
        var annaotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annaotationView == nil {
            annaotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annaotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annaotationView?.rightCalloutAccessoryView = btn
        } else {
            annaotationView?.annotation = annotation
        }
        return annaotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placename = capital.title
        let placeInfO = capital.info
        
        let ac = UIAlertController(title: placename, message: placeInfO, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default))
        present(ac, animated: true)
    }

}

