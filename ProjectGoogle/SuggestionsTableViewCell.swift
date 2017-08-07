//
//  SuggestionsTableViewCell.swift
//  ProjectGoogle
//
//  Created by Kevin Chan on 3/27/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

protocol SuggestionsTableViewCellDelegate {
    
    func heartButtonWasTapped(suggestionsTableViewCell: SuggestionsTableViewCell)
    
}


class SuggestionsTableViewCell: UITableViewCell {
    
    
    var locationImageView: UIImageView!
    var nameLabel: UILabel!
    var locationLabel: UILabel!
    var ageLabel: UILabel!
    var locationSymbolImageView: UIImageView!
    var heartButton: UIButton!
    var heartCounter: Int = 0
    
    var delegate: SuggestionsTableViewCellDelegate?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        locationImageView = UIImageView()
        nameLabel = UILabel()
        locationLabel = UILabel()
        locationSymbolImageView = UIImageView()
        ageLabel = UILabel()
        heartButton = UIButton()
        
        
        addSubview(locationImageView)
        addSubview(nameLabel)
        addSubview(locationLabel)
        addSubview(locationSymbolImageView)
        addSubview(ageLabel)
        addSubview(heartButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        locationImageView.frame = CGRect(x: 10, y: 0, width: 50, height: 50)
        locationImageView.center = CGPoint(x: locationImageView.center.x, y: frame.height / 2.0)
        locationImageView.layer.cornerRadius = locationImageView.frame.width / 2.0
        locationImageView.clipsToBounds = true
        
        nameLabel.frame = CGRect(x: locationImageView.frame.origin.x + locationImageView.frame.width + 10, y: frame.height * 0.2, width: frame.width * 0.6, height: frame.height * 0.2)
        
        
        locationLabel.frame = CGRect(x: nameLabel.frame.origin.x + 25, y: nameLabel.frame.origin.y + nameLabel.frame.height, width: frame.width * 0.5, height: frame.height * 0.2)
        
        locationSymbolImageView.frame = CGRect(x: nameLabel.frame.origin.x, y: 0, width: 15, height: 15)
        locationSymbolImageView.center = CGPoint(x: locationSymbolImageView.center.x, y: locationLabel.frame.origin.y + locationLabel.frame.height / 2.0)
        locationSymbolImageView.layer.cornerRadius = locationSymbolImageView.frame.width / 2.0
        locationSymbolImageView.clipsToBounds = true

        
        ageLabel.frame = CGRect(x: nameLabel.frame.origin.x, y: locationLabel.frame.origin.y + locationLabel.frame.height, width: frame.width * 0.5, height: frame.height * 0.2)
        
        heartButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        heartButton.center = CGPoint(x: frame.width * 0.9, y: frame.height / 2.0)
        heartButton.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
        
    }
    
    func setupSuggestions(name: String, location: String, age: Int, coord: Coordinates, image: UIImage) {
        nameLabel.text = "Name: \(name)"
        nameLabel.textColor = .blue
        locationLabel.text = location
        locationLabel.textColor = .red
        ageLabel.text = "Age: \(age)"
        ageLabel.textColor = .blue
        locationImageView.image = image
        locationSymbolImageView.image = #imageLiteral(resourceName: "locationsymbol")
        heartButton.setImage(#imageLiteral(resourceName: "heartwhite"), for: .normal)
        
        
    }
    
    func heartTapped() {
        delegate?.heartButtonWasTapped(suggestionsTableViewCell: self)
    }

}
