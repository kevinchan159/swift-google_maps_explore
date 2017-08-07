//
//  FindViewController.swift
//  ProjectGoogle
//
//  Created by Kevin Chan on 3/27/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {
    
    var coord: Coordinates!
    
    var longLabel: UILabel!
    var latLabel: UILabel!
    var latTextField: UITextField!
    var longTextField: UITextField!
    var findButton: UIButton!
    var blueLocationImageView: UIImageView!
    
    var latSuggestionLabel: UILabel!
    var longSuggestionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Find Location"
        view.backgroundColor = .white
        
        latLabel = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.3, width: view.frame.width * 0.2, height: view.frame.height * 0.1))
        latLabel.text = "Latitude:"
        latLabel.textColor = .blue
        view.addSubview(latLabel)
        
        longLabel = UILabel(frame: CGRect(x: latLabel.frame.origin.x, y: view.frame.height * 0.5, width: view.frame.width * 0.2, height: view.frame.height * 0.1))
        longLabel.text = "Longitude:"
        longLabel.textColor = .blue
        view.addSubview(longLabel)
        
        latTextField = UITextField(frame: CGRect(x: latLabel.frame.origin.x + latLabel.frame.width + 10, y: latLabel.frame.origin.y, width: view.frame.width * 0.7, height: view.frame.height * 0.05))
        latTextField.center = CGPoint(x: latTextField.center.x, y: latLabel.frame.origin.y + latLabel.frame.height/2.0)
        latTextField.borderStyle = .roundedRect
        view.addSubview(latTextField)
        
        longTextField = UITextField(frame: CGRect(x: latTextField.frame.origin.x, y: longLabel.frame.origin.y, width: view.frame.width * 0.7, height: view.frame.height * 0.05))
        longTextField.center = CGPoint(x: longTextField.center.x, y: longLabel.frame.origin.y + longLabel.frame.height/2.0)
        longTextField.borderStyle = .roundedRect
        view.addSubview(longTextField)
        
        findButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.3, height: view.frame.height * 0.07))
        findButton.center = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.7)
        findButton.setTitle("Find", for: .normal)
        findButton.setTitleColor(.white, for: .normal)
        findButton.addTarget(self, action: #selector(newLocation), for: .touchUpInside)
        findButton.backgroundColor = .blue
        view.addSubview(findButton)
        
        latSuggestionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.5, height: view.frame.height * 0.03))
        latSuggestionLabel.center = CGPoint(x: latTextField.center.x, y: latTextField.frame.origin.y + latTextField.frame.height + 10)
        latSuggestionLabel.text = "-180.0 <= Lat <= 180.0"
        latSuggestionLabel.textColor = .blue
        view.addSubview(latSuggestionLabel)
        
        longSuggestionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.5, height: view.frame.height * 0.03))
        longSuggestionLabel.center = CGPoint(x: longTextField.center.x, y: longTextField.frame.origin.y + longTextField.frame.height + 10)
        longSuggestionLabel.text = "-90.0 <= Long <= 90.0"
        longSuggestionLabel.textColor = .blue
        view.addSubview(longSuggestionLabel)
        
        blueLocationImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.3, height: view.frame.width * 0.3))
        blueLocationImageView.image = #imageLiteral(resourceName: "bluelocationsymbol")
        blueLocationImageView.center = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.2)
        blueLocationImageView.layer.cornerRadius = blueLocationImageView.frame.width / 2.0
        blueLocationImageView.clipsToBounds = true
        view.addSubview(blueLocationImageView)
    }

    func newLocation() {
        if let latText = latTextField.text {
            if (latText != "" && Double(latText) != nil) {
                if (Double(latText)! >= -180.0 && Double(latText)! <= 180.0) {
                    print("changed long")
                    coord.lat = Double(latText)!
                    print(coord.long)
                }
            }
        }
        if let longText = longTextField.text {
            if (longText != "" && Double(longText) != nil) {
                if (Double(longText)! >= -90.0 && Double(longText)! <= 90.0) {
                    print("changed lat")
                    coord.long = Double(longText)!
                    print(coord.lat)
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }


}
