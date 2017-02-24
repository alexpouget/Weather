//
//  ViewController.swift
//  Weather
//
//  Created by alexandre pouget on 24/02/2017.
//  Copyright © 2017 alexandre pouget. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet private weak var locationLabel: UILabel!
    let locationManager = CLLocationManager()
    var weather: Weather = Weather()
    var data : [Weather.Row] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestWhenInUseAuthorization()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        guard let location = locations.first else {
            print("Erreur location")
            return
        }
        locationLabel.text = "\(String(location.coordinate.latitude)),  \(String(location.coordinate.longitude))"
        
        
        data = weather.getJsonWheater(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude))
        
        
        self.tableView.reloadData()
        
        //stop la recherche de location
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(data.count<24){
            return data.count
        }
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.data[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        
        cell.textLabel?.text = "\(data.time)"
        cell.detailTextLabel?.text = "\(data.temp) °C"
        cell.layer.cornerRadius = 10
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        switch data.icon {
        case "clear-day":
            
            cell.backgroundColor = UIColor.blue
        case "partly-cloudy-day":
            cell.backgroundColor = UIColor.lightGray
        case "partly-cloudy-night":
            cell.backgroundColor = UIColor.darkGray
        default:
            cell.textLabel?.textColor = UIColor.black
            cell.backgroundColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.black
        }
        
 
        return cell
    }
    
    
}

