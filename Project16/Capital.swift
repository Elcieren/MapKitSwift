//
//  Capital.swift
//  Project16
//
//  Created by Eren Elçi on 31.10.2024.
//

import UIKit
import MapKit

class Capital: NSObject , MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var wikipediaURL: URL?
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String ,wikipediaURL: URL?) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.wikipediaURL = wikipediaURL
    }
    
}
