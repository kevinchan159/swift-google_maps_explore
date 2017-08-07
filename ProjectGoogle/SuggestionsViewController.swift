//
//  SuggestionsViewController.swift
//  ProjectGoogle
//
//  Created by Kevin Chan on 3/27/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class Suggestions {
    
    var name: String
    var location: String
    var age: Int
    var image: UIImage
    var coord: Coordinates
    var snippet: String?

    
    init(name: String, location: String, age: Int, coord: Coordinates, image: UIImage) {
        self.name = name
        self.location = location
        self.age = age
        self.coord = coord
        self.image = image
    }
    
}

class SuggestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SuggestionsTableViewCellDelegate {
    
    var suggestions = [Suggestions]()
    var suggCoord: Coordinates!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Suggestions"
        
        fetchSuggestions()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.rowHeight = 100
        tableView.separatorColor = .blue
        tableView.register(SuggestionsTableViewCell.self, forCellReuseIdentifier: "Sug")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        
    }

    func fetchSuggestions() {
        let sug1 = Suggestions(name: "Big Ben", location: "London", age: 158, coord: Coordinates(lat: 51.500869, long: -0.124690) ,image: #imageLiteral(resourceName: "bigben"))
        sug1.snippet = "A British cultural icon, the tower is one of the most prominent symbols of the United Kingdom and is often in the establishing shot of films set in London."
        
        let sug2 = Suggestions(name: "Colesseum", location: "Rome", age: 1937, coord: Coordinates(lat: 41.890346, long: 12.492285), image: #imageLiteral(resourceName: "colesseum"))
        sug2.snippet = "The Colesseum is an oval amphitheatre in the centre of the city of Rome, Italy. Built of concrete and sand, it is the largest amphitheatre ever built."
        
        let sug3 = Suggestions(name: "Eiffel Tower", location: "Paris", age: 128, coord: Coordinates(lat: 48.858525, long: 2.294567), image: #imageLiteral(resourceName: "eiffel"))
        sug3.snippet = "The Eiffel Tower is the most-visited paid monument in the world; 6.91 million people ascended it in 2015."
        
        let sug4 = Suggestions(name: "Great Wall of China", location: "China", age: 2238, coord: Coordinates(lat: 40.432161, long: 116.570300), image: #imageLiteral(resourceName: "greatwall"))
        sug4.snippet = "The Great Wall of China is a series of fortifications made of stone, brick, tamped earth, wood, and other materials, generally built along an east-to-west line across the historical northern borders of China to protect the Chinese states and empires against the raids and invasions of the various nomadic groups of the Eurasian Steppe."
        
        let sug5 = Suggestions(name: "Leaning Tower of Pisa", location: "Pisa", age: 645, coord: Coordinates(lat: 43.723107, long: 10.396651), image: #imageLiteral(resourceName: "leaning"))
        sug5.snippet = "The Leaning Tower of Pisa is known worldwide for its unintended tilt."
        
        let sug6 = Suggestions(name: "Statue of Liberty", location: "New York", age: 142, coord: Coordinates(lat: 40.689282, long: -74.044576), image: #imageLiteral(resourceName: "statue"))
        sug6.snippet = "The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States."
        
        let sug7 = Suggestions(name: "Opera House", location: "City of Sydney", age: 44, coord: Coordinates(lat: -33.856740, long: 151.215436) , image: #imageLiteral(resourceName: "opera"))
        sug7.snippet = "An opera house is a theatre building used for opera performances that consists of a stage, an orchestra pit, audience seating, and backstage facilities for costumes and set building."
        
        let sug9 = Suggestions(name: "Mount Rushmore", location: "South Dakota", age: 90, coord: Coordinates(lat: 43.879203, long: -103.458906), image: #imageLiteral(resourceName: "rushmore"))
        sug9.snippet = "Mount Rushmore features 60-foot sculptures of the heads of four United States presidents: George Washington, Thomas Jefferson, Theodore Roosevelt, and Abraham Lincoln."
        
        suggestions = [sug1, sug2, sug3, sug4, sug5 , sug6, sug7, sug9]

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Sug") as? SuggestionsTableViewCell {
            let sugg = suggestions[indexPath.row]
            cell.setupSuggestions(name: sugg.name, location: sugg.location, age: sugg.age, coord: sugg.coord, image: sugg.image)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sugg = suggestions[indexPath.row]
        suggCoord.lat = sugg.coord.lat
        suggCoord.long = sugg.coord.long
        suggCoord.title = sugg.name
        suggCoord.snippet = sugg.snippet
        
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    func heartButtonWasTapped(suggestionsTableViewCell: SuggestionsTableViewCell) {
        suggestionsTableViewCell.heartCounter = suggestionsTableViewCell.heartCounter + 1
        if (suggestionsTableViewCell.heartCounter % 2 == 0) {
            suggestionsTableViewCell.heartButton.setImage(#imageLiteral(resourceName: "heartwhite"), for: .normal)
        } else {
            suggestionsTableViewCell.heartButton.setImage(#imageLiteral(resourceName: "heart_red"), for: .normal)
        }
    }
    
    
    
    
    
    
    
    
    
    

}
