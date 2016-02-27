//
//  AbreMapaAnnotation.swift
//  BuscaMapa
//
//  Created by Usuário Convidado on 27/02/16.
//  Copyright © 2016 Thiago Nogueira. All rights reserved.
//

import UIKit
import MapKit

class AbreMapaAnnotation: NSObject, MKAnnotation  {

    var coordinate: CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    var mkMapItem:MKMapItem?
    
    init(coordinate: CLLocationCoordinate2D, title:String?, subtitle: String?, mkMapItem: MKMapItem?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.mkMapItem = mkMapItem
    }
   
}
