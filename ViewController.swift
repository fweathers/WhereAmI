//
//  ViewController.swift
//  WhereAmI
//
//  Created by Felicia Weathers on 8/24/16.
//  Copyright © 2016 Felicia Weathers. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //print(locations)
        var userLocation: CLLocation = locations[0]
        
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        self.speedLabel.text = "\(userLocation.speed)"
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil) {
                
                print(error)
                
            } else {
                
                if let placemark = placemarks?[0] {
                    
                    var address = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        address += placemark.subThoroughfare! + " "
                        
                    }
                    
                    if placemark.thoroughfare != nil {
                        
                        address += placemark.thoroughfare! + "\n"
                    }
                    
                    if placemark.subLocality != nil {
                        
                        address += placemark.subLocality! + " "
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        
                        address += placemark.subAdministrativeArea! + " "
                        
                    }
                    
                    if placemark.postalCode != nil {
                        
                        address += placemark.postalCode! + "\n"
                        
                    }
                    
                    if placemark.country != nil {
                        
                        address += placemark.country!
                    }
                    
                    self.addressLabel.text = address
                    
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

