//
//  Weather.swift
//  Weather
//
//  Created by alexandre pouget on 24/02/2017.
//  Copyright © 2017 alexandre pouget. All rights reserved.
//

import Foundation

class Weather {
    
    private var key = "57c21dc3607017fff0f4a5206f50aa63"
    
    struct Row {
        var time:String
        var temp:String
        var icon:String
    }
    
    
    func getJsonWheater(latitude: String,longitude: String)-> [Row]{
        var rows:[Row] = []
        var locked = true
        if(!Connectivity.hasConnectivity()){
            print("connection a internet impossible")
            return rows
        }
        let url: URL = URL(string: "https://api.darksky.net/forecast/\(self.key)/\(latitude),\(longitude)?exclude=daily,minutely,currently,flags,alerts")!
        print(url.absoluteString)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                let hourlys = json?["hourly"] as! [String:Any]
                let hourlyDatas = hourlys["data"] as! [[String : Any]]?
                for item in hourlyDatas!{
                    
                    let time = NSDate(timeIntervalSince1970: item["time"]! as! TimeInterval)
                    let timeFormated = self.formatDate(date: time,format: "HH:mm")
                    var temp = item["temperature"]! as! Double
                    temp = self.farenheitToCelsius(temperature: temp)
                    let icon = item["icon"]

                    rows.append(Row(time: timeFormated, temp: String(temp), icon: icon as! String))
                }
                
            }catch{
                print("erreur de serialisation")
            }
           locked = false
        }
        task.resume()
        
        while(locked){
        }
        return rows
    }
    
    func farenheitToCelsius(temperature: Double)->Double{
        return round(temperature-32)
    }

    func formatDate(date : NSDate,format : String)-> String{
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = format
        let timeString = dayTimePeriodFormatter.string(from: date as Date)
        return timeString
    }
    
    
    
    
}
