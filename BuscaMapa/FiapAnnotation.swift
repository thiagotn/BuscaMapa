//
//  FiapAnnotation.swift
//  BuscaMapa
//
//  Created by Usuário Convidado on 27/02/16.
//  Copyright © 2016 Thiago Nogueira. All rights reserved.
//

import UIKit
import MapKit

class FiapAnnotation: NSObject, MKAnnotation {
   
    var coordinate: CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    
    init(coordinate: CLLocationCoordinate2D, title:String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
