//
//  ViewController.swift
//  RESTAPISAMPLE1
//
//  Created by Tatsuya Moriguchi on 7/16/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&formatted=0"
        /*
         OK
         2020-07-17T05:12:45+00:00
         2020-07-17T19:35:07+00:00
         2020-07-17T12:23:56+00:00
         2020-07-17T05:12:45+00:00
         */
        
        getData(from: url)

    }
    
    private func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, responseguard, error
            in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
                
            }
            // have data
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("Failed to convert \(error.localizedDescription)")
                
            }
            guard let json = result else {
                return
            }
            print(json.status)
            print(json.results.sunrise)
            print(json.results.sunset)
            print(json.results.solar_noon)
            print(json.results.sunrise)
        })
        task.resume()
        
    }

}

struct Response: Codable {
    let results: MyResult
    let status: String
}

struct MyResult: Codable {
    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: Int
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
}





/*

 // formatted=0
 {
   "results":
   {
     "sunrise":"2015-05-21T05:05:35+00:00",
     "sunset":"2015-05-21T19:22:59+00:00",
     "solar_noon":"2015-05-21T12:14:17+00:00",
     "day_length":51444,
     "civil_twilight_begin":"2015-05-21T04:36:17+00:00",
     "civil_twilight_end":"2015-05-21T19:52:17+00:00",
     "nautical_twilight_begin":"2015-05-21T04:00:13+00:00",
     "nautical_twilight_end":"2015-05-21T20:28:21+00:00",
     "astronomical_twilight_begin":"2015-05-21T03:20:49+00:00",
     "astronomical_twilight_end":"2015-05-21T21:07:45+00:00"
   },
    "status":"OK"
 }
 
///////
 
 {
   "results":
   {
     "sunrise":"7:27:02 AM",
     "sunset":"5:05:55 PM",
     "solar_noon":"12:16:28 PM",
     "day_length":"9:38:53",
     "civil_twilight_begin":"6:58:14 AM",
     "civil_twilight_end":"5:34:43 PM",
     "nautical_twilight_begin":"6:25:47 AM",
     "nautical_twilight_end":"6:07:10 PM",
     "astronomical_twilight_begin":"5:54:14 AM",
     "astronomical_twilight_end":"6:38:43 PM"
   },
    "status":"OK"
 }

 */

