//
//  MapViewController.swift
//  ProjectGoogle
//
//  Created by Kevin Chan on 3/27/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit
import GoogleMaps

class Coordinates {
    
    var long: Double
    var lat: Double
    var title: String?
    var snippet: String?
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
}

class MapViewController: UIViewController {
    
    var camera: GMSCameraPosition!
    var mapView: GMSMapView!
    var coordinates: Coordinates!
    var newCoordinates: Coordinates!
    var markerFrom: GMSMarker!
    var markerTo: GMSMarker!
    var zoomSlider: UISlider!
    var zoomSliderLabel: UILabel!
    //var distanceLabel: UILabel!
    var path: GMSMutablePath?
    var pathPolyLineArray = [GMSPolyline] ()
    var polyLineCounter: Int = 0
    var gmsDistanceAPI: GMSDistanceAPI!
    var distance: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Project Google"
        view.backgroundColor = .white
        
        
        GMSServices.provideAPIKey("AIzaSyAovuAnYPHNSTz5Itii8Y6zgGVdYhmqbf4")

        
        zoomSlider = UISlider(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.5, height: view.frame.height * 0.1))
        zoomSlider.center = CGPoint(x: view.frame.width/2.0, y: view.frame.height * 0.95)
        zoomSlider.minimumValue = 1
        zoomSlider.maximumValue = 20
        zoomSlider.isContinuous = true
        zoomSlider.tintColor = .red
        zoomSlider.value = 10
        zoomSlider.addTarget(self, action: #selector(sliderChanged), for: UIControlEvents.valueChanged)
        
        zoomSliderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.5, height: view.frame.height * 0.1))
        zoomSliderLabel.textAlignment = .center
        zoomSliderLabel.center = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.9)
        zoomSliderLabel.text = "Zoom Slider"
        zoomSliderLabel.textColor = .red
        
//        distanceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.5, height: view.frame.height * 0.05))
//        distanceLabel.center = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.7)
//        distanceLabel.text = "Distance: "
//        distanceLabel.textColor = .red
        
        coordinates = Coordinates(lat: 40.6609917, long: -73.9827139)
        newCoordinates = Coordinates(lat: 0.0, long: 0.0)
        
        gmsDistanceAPI = GMSDistanceAPI()
        gmsDistanceAPI.originLat = coordinates.lat
        gmsDistanceAPI.originLong = coordinates.long

        
        
        camera = GMSCameraPosition.camera(withLatitude: coordinates.lat, longitude: coordinates.long, zoom: zoomSlider.value)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), camera: camera)
        view = mapView
        view.addSubview(zoomSlider)
        view.addSubview(zoomSliderLabel)
//        view.addSubview(distanceLabel)

        
        
        markerFrom = GMSMarker()
        markerFrom.position = CLLocationCoordinate2D(latitude: 40.6609917, longitude: -73.9827139)
        markerFrom.title = "Bishop Boardman Apartments"
        markerFrom.map = mapView
        
        markerTo = GMSMarker()

        
        path = GMSMutablePath()
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Find", style: .plain, target: self, action: #selector(findLocation))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Suggestions", style: .plain, target: self, action: #selector(showSuggestions))
        
    }

    func findLocation() {
        let findViewController = FindViewController()
        findViewController.coord = newCoordinates
        navigationController?.pushViewController(findViewController, animated: true)
    }
    
    func showSuggestions() {
        let suggestionsViewController = SuggestionsViewController()
        suggestionsViewController.suggCoord = newCoordinates
        navigationController?.pushViewController(suggestionsViewController, animated: true)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if (self.isMovingToParentViewController == false) {
            
            if newCoordinates.lat != 0.0 && newCoordinates.long != 0.0 {

//                gmsDistanceAPI.destLat = newCoordinates.lat
//                gmsDistanceAPI.destLong = newCoordinates.long
//                gmsDistanceAPI.fetchDistance(completion: { (distance: String) in
//                    self.distance = distance
//                })
//                
//                if let d = self.distance {
//                    distanceLabel.text = "Distance: \(d)"
//                }
                
                
                
                mapView.camera = GMSCameraPosition.camera(withLatitude: newCoordinates.lat, longitude: newCoordinates.long, zoom: 10)
                markerTo?.position = CLLocationCoordinate2D(latitude: newCoordinates.lat, longitude: newCoordinates.long)
                markerTo?.map = mapView
                path?.removeAllCoordinates()
                path?.add(CLLocationCoordinate2DMake(coordinates.lat, coordinates.long))
                path?.add(CLLocationCoordinate2DMake(newCoordinates.lat, newCoordinates.long))
                let pathPolyLine = GMSPolyline(path: path)
                pathPolyLine.strokeWidth = 1.5
                pathPolyLineArray.append(pathPolyLine)
                polyLineCounter = polyLineCounter + 1
                pathPolyLine.map = mapView
                
                if polyLineCounter > 1 {
                    pathPolyLineArray[polyLineCounter - 2].map = nil
                }
            }
            
//            DispatchQueue.main.async {
//                self.gmsDistanceAPI.destLat = self.newCoordinates.lat
//                self.gmsDistanceAPI.destLong = self.newCoordinates.long
//                self.gmsDistanceAPI.fetchDistance(completion: { (distance: String) in
//                    self.distance = distance
//                    print("inside")
//                })
//            }
//            
//            if let d = self.distance {
//                distanceLabel.text = "Distance: \(d)"
//            }
            
            
            if let title = newCoordinates.title {
                markerTo?.title = title
            }
            if let snippet = newCoordinates.snippet {
                markerTo?.snippet = snippet
            }
            
            
        }
    }
    
    func sliderChanged() {
        //mapView.camera = GMSCameraPosition.camera(withLatitude: coordinates.lat, longitude: coordinates.long, zoom: zoomSlider.value)
        mapView.animate(toZoom: zoomSlider.value)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
