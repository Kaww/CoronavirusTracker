//
//  CountryViewController.swift
//  Coronavirus
//
//  Created by kaww on 25/02/2020.
//  Copyright © 2020 KAWRANTIN LE GOFF. All rights reserved.
//

import UIKit
import MapKit

class CountryViewController: UIViewController, MKMapViewDelegate {
    
    var country: Country! = nil
    
    let map = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = country.country
        view.backgroundColor = .black
        
        setupMap()
        setupLabels()
    }
    
    
    // MARK: -- SETUP METHODS
    
    private func setupMap() {
//        map.backgroundColor = .systemGray
        map.layer.cornerRadius = 15
        map.mapType = .standard
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: country.latitude, longitude: country.longitude)
        annotation.title = country.country
        annotation.subtitle = "\(country.confirmed) confirmed"
        map.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
        map.setRegion(region, animated: true)
        
        view.addSubview(map)
        setupMapConstraints()
    }
    
    private func setupMapConstraints() {
        map.translatesAutoresizingMaskIntoConstraints = false
        map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        map.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        map.widthAnchor.constraint(equalToConstant: view.frame.width - 20).isActive = true
        map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
    }
    
    private func setupLabels() {
        let confirmedLabel = UILabel()
        confirmedLabel.text = "🤒 \(country.confirmed)"
        
        let recoveredLabel = UILabel()
        recoveredLabel.text = "😀 \(country.recovered)"
        
        let deathsLabel = UILabel()
        deathsLabel.text = "☠️ \(country.deaths)"
        
        let labels = [confirmedLabel, recoveredLabel, deathsLabel]
        
        for label in labels {
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 18, weight: .medium)
        }
        
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: map.bottomAnchor, constant: 20).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
        
        let lastUpdateLabel = UILabel()
        lastUpdateLabel.text = "Last update: \(country.lastUpdate)"
        lastUpdateLabel.textAlignment = .center
        lastUpdateLabel.font = .systemFont(ofSize: 15)
        view.addSubview(lastUpdateLabel)
        
        lastUpdateLabel.translatesAutoresizingMaskIntoConstraints = false
        lastUpdateLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        lastUpdateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lastUpdateLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
    }
    
    
    // MARK: -- CLASS METHODS
    
    //...
}
