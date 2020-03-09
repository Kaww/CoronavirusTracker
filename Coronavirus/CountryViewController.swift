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
        map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -110).isActive = true
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
        
        let labelsStackView = UIStackView(arrangedSubviews: labels)
        labelsStackView.axis = .horizontal
        labelsStackView.distribution = .equalSpacing
        view.addSubview(labelsStackView)
        
//        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
//        labelsStackView.topAnchor.constraint(equalTo: map.bottomAnchor, constant: 10).isActive = true
//        labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        labelsStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
        
        let recoverPercentageLabel = UILabel()
        recoverPercentageLabel.text = "\(getRecoveredPercentage())% recovered"
        recoverPercentageLabel.textAlignment = .center
        recoverPercentageLabel.font = .systemFont(ofSize: 18, weight: .medium)
        view.addSubview(recoverPercentageLabel)
        
//        recoverPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
//        recoverPercentageLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15).isActive = true
//        recoverPercentageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        recoverPercentageLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
        
        let lastUpdateLabel = UILabel()
        lastUpdateLabel.text = "Last update: \(country.lastUpdate)"
        lastUpdateLabel.textAlignment = .center
        lastUpdateLabel.font = .systemFont(ofSize: 15)
        view.addSubview(lastUpdateLabel)
        
        let subViews = [labelsStackView, recoverPercentageLabel, lastUpdateLabel]
        
        let infosStackView = UIStackView(arrangedSubviews: subViews)
        infosStackView.axis = .vertical
        infosStackView.distribution = .equalSpacing
        infosStackView.alignment = .fill
        view.addSubview(infosStackView)
        
        infosStackView.translatesAutoresizingMaskIntoConstraints = false
        infosStackView.topAnchor.constraint(equalTo: map.bottomAnchor, constant: 10).isActive = true
        infosStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infosStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 30).isActive = true
        infosStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
//        lastUpdateLabel.translatesAutoresizingMaskIntoConstraints = false
//        lastUpdateLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
//        lastUpdateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        lastUpdateLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
    }
    
    private func getRecoveredPercentage() -> Double {
        let totalConfirmed = Double(country.confirmed)
        let totalRecovered = Double(country.recovered)
        
        if totalConfirmed == 0 {
            return 0.0
        }
        
        return round(totalRecovered / totalConfirmed * 1000) / 10
    }
}
