//
//  ViewController.swift
//  BuscaMapa
//
//  Created by Usuário Convidado on 27/02/16.
//  Copyright © 2016 Thiago Nogueira. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var mapView: MKMapView!

    let fiapLocation:CLLocationCoordinate2D =    CLLocationCoordinate2DMake(-23.573978,-46.623272)
    
//    let metroVilaMarinaLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(-23.573978,-46.623272)
    
   // let metroVilaMarianaAnnotation:MKPointAnnotation = MKPointAnnotation()
    
//    let ml = CLLocationCoordinate2DMake(-23.573978,-46.623272)
//    

    let metroAnnotation = MetroAnnotation(coordinate: CLLocationCoordinate2DMake(-23.589541, -46.634701), title: "Metrô Vila Mariana", subtitle: "Linha Azul")

    let fiapAnnotation = FiapAnnotation(coordinate: CLLocationCoordinate2DMake(-23.573978,-46.623272), title: "FIAP", subtitle: "Campus Aclimação")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView.showsUserLocation = true
        self.mapView.region = MKCoordinateRegionMakeWithDistance(fiapLocation, 1200, 1200)
        
        /*
        self.metroVilaMarianaAnnotation.coordinate = CLLocationCoordinate2DMake(-23.589541, -46.634701)
        self.metroVilaMarianaAnnotation.title = "Metrô Vila Mariana"
        self.metroVilaMarianaAnnotation.subtitle = "Estação da linha azul"
        
        self.mapView.addAnnotation(metroVilaMarianaAnnotation)
        */
        
        self.mapView.addAnnotations([metroAnnotation, fiapAnnotation])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeMapType(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
           self.mapView.mapType = MKMapType.Standard
        } else if (sender.selectedSegmentIndex == 1) {
           self.mapView.mapType = MKMapType.Satellite
        } else if (sender.selectedSegmentIndex == 2) {
           self.mapView.mapType = MKMapType.Hybrid
        }
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MetroAnnotation {
            let reuseId = "reuseMetroAnnotation"
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if anView == nil {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.image = UIImage(named: "metroLogo")
                anView!.canShowCallout = true
                anView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
                
                return anView
            }
        } else if annotation is FiapAnnotation {
            let reuseId = "reuseFiapAnnotation"
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if anView == nil {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.image = UIImage(named: "interesseLogo")
                anView!.canShowCallout = true
                anView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
                
                return anView
            }
            
        } else if annotation is AbreMapaAnnotation {
            let reuseId = "reuseAbreMapaAnnotation"
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if anView == nil {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.image = UIImage(named: "userLogo")
                anView!.canShowCallout = true
                anView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
                
                return anView
            }
            
        }
        return nil
    }

    func mapView(mapView: MKMapView, annotationView view:
        MKAnnotationView, calloutAccessoryControlTapped control:
        UIControl) {
        
        if (view.annotation is MetroAnnotation) {
            let url:NSURL = NSURL(string: "http://www.metro.sp.gov.br")!
            UIApplication.sharedApplication().openURL(url)
            print(view.annotation?.title)
            
        } else if (view.annotation is FiapAnnotation) {
            let url:NSURL = NSURL(string: "http://www.fiap.com.br")!
            UIApplication.sharedApplication().openURL(url)
            print(view.annotation?.title)
            
        } else if (view.annotation is AbreMapaAnnotation) {
            
            displayRegionCenteredOnMapItem((view.annotation as! AbreMapaAnnotation).mkMapItem!)
        }
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar.text
        request.region = self.mapView.region
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler {(response, error) -> Void in
            if (error == nil) {
            var placemarks: [AbreMapaAnnotation] = []
                for item: MKMapItem in response!.mapItems {
                    let place = AbreMapaAnnotation(coordinate: item.placemark.coordinate, title: item.name, subtitle: nil, mkMapItem: item)
                    placemarks.append(place)
                }
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.addAnnotations(placemarks)
            }
        }
    }

    func displayRegionCenteredOnMapItem (from:MKMapItem){
        //Obtem a localizacao do item passado como parametro
        let fromLocation: CLLocation = from.placemark.location!
        let region = MKCoordinateRegionMakeWithDistance(fromLocation.coordinate, 10000, 10000)
        let opts = [
        MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan:region.span),
        MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: region.center)
        ]
        from.openInMapsWithLaunchOptions(opts)
    }
}

