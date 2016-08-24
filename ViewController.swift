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
                    
                    print(placemark)
                    
                    var subThoroughfare = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        subThoroughfare = placemark.subThoroughfare!
                        
                    }
                    
                    var thoroughfare = ""
                    
                    if placemark.thoroughfare != nil {
                        
                        thoroughfare = placemark.thoroughfare!
                    }
                    
                    var sublocality = ""
                    
                    if placemark.subLocality != nil {
                        
                        sublocality = placemark.subLocality!
                    }
                    
                    var subAdministrativeArea = ""
                    
                    if placemark.subAdministrativeArea != nil {
                        
                        subAdministrativeArea = placemark.subAdministrativeArea!
                        
                    }
                    
                    var postalCode = ""
                    
                    if placemark.postalCode != nil {
                        
                        postalCode = placemark.postalCode!
                        
                    }
                    
                    var country = ""
                    
                    if placemark.country != nil {
                        
                        country = placemark.country!
                    }
                    
                    print(subThoroughfare + " " + thoroughfare + "\n" + sublocality + "\n" + subAdministrativeArea + "\n" + postalCode + "\n" + country)
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

