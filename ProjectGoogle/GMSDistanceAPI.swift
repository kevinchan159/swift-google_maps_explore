//
//  GMSDistanceAPI.swift
//  ProjectGoogle
//
//  Created by Kevin Chan on 3/30/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//


import UIKit


class GMSDistanceAPI {
    var originLat: Double = 0.0
    var originLong: Double = 0.0
    var destLat: Double = 0.0
    var destLong: Double = 0.0

    

    func fetchDistance(completion: @escaping (String) -> ()) {
        
        let link = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=\(originLat),\(originLong)&destinations=\(destLat)%2C\(destLong)%7C&key=AIzaSyCxDEA0ckQ-Jy-DO2K3NTwL0ZZ9ib9gCkw"
        
        guard let url = URL(string: link) else {
            return
        }
        
        print(url)
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let unwrappedData = data {
                if let dictionary = self.getDictionaryFromData(data: unwrappedData) {
                    if let distance = self.getDistanceFromDictionary(dict: dictionary) {
                        completion(distance)
                    }
                }
            }
            
        }
        task.resume()
        
    }
    func getDictionaryFromData(data: Data) -> [String: Any]? {
        
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            if let jsonDictionary = jsonObject as? [String: Any] {
                return jsonDictionary
            }
        }
        return nil

    }

    func getDistanceFromDictionary(dict: [String: Any]) -> String? {
        
        if let rows = dict["rows"] as? [[String: Any]]{
            for row in rows {
                if let elements = row["elements"] as? [[String: Any]]{
                    for element in elements {
                        if let distance = element["distance"] as? [String: Any]{
                            if let text = distance["text"] as? String {
                                return text
                            }
                        }
                    }
                }
            }
        }
        
        return nil
        }
    
    
    
    
    
}
