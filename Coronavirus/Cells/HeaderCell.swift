//
//  HeaderCell.swift
//  Coronavirus
//
//  Created by kaww on 28/02/2020.
//  Copyright © 2020 KAWRANTIN LE GOFF. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    private var titleLabel = UILabel()
    private var confirmedLabel = UILabel()
    private var recoveredLabel = UILabel()
    private var deathsLabel = UILabel()
    private var lastUpdateLabel = UILabel()
    
    var countries: [Country]? {
        didSet {
            if let countries = countries {
                let recoveredPercentage = getRecoveredPercentage(countries)
                titleLabel.text = "\(countries.count) countries, \(recoveredPercentage)% recovered"
                confirmedLabel.text = "🤒 \(getTotalConfirmed(countries))"
                recoveredLabel.text = "😀 \(getTotalRecovered(countries))"
                deathsLabel.text = "☠️ \(getTotalDeaths(countries))"
            }
        }
    }
    
    var lastUpdate: String? {
        didSet {
            if let date = lastUpdate {
                lastUpdateLabel.text = "Last update: \(date)"
            } else {
                if let date = CoronavirusAPI.lastUpdateDate {
                    lastUpdateLabel.text = "Last update: \(date)"
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorManager.headerBackgroundColor
        
        setupLabels()
        setupLabelsConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }
    
    private func setupLabels() {
        titleLabel.text = "Total: 0"
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        titleLabel.textColor = .white
        addSubview(titleLabel)
        
        confirmedLabel.text = "🤒 0"
        confirmedLabel.font = .systemFont(ofSize: 13)
        confirmedLabel.textColor = .white
        confirmedLabel.textAlignment = .center
        
        recoveredLabel.text = "😀 0"
        recoveredLabel.font = .systemFont(ofSize: 13)
        recoveredLabel.textColor = .white
        recoveredLabel.textAlignment = .center
        
        deathsLabel.text = "☠️ 0"
        deathsLabel.font = .systemFont(ofSize: 13)
        deathsLabel.textColor = .white
        deathsLabel.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [confirmedLabel, recoveredLabel, deathsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        lastUpdateLabel.text = ""
        lastUpdateLabel.font = .systemFont(ofSize: 12)
        addSubview(lastUpdateLabel)
        
        setupStackViewConstraints(stackView: stackView)
    }
    
    private func setupStackViewConstraints(stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: topAnchor, constant: frame.height * 0.75).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
    }
    
    private func setupLabelsConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: frame.height / 3).isActive = true
        
        lastUpdateLabel.translatesAutoresizingMaskIntoConstraints = false
        lastUpdateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lastUpdateLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
    }
    
    private func getTotalConfirmed(_ countries: [Country]) -> Int {
        var totalConfirmed = 0
        for country in countries {
            totalConfirmed += country.confirmed
        }
        
        return totalConfirmed
    }
    
    private func getTotalRecovered(_ countries: [Country]) -> Int {
        var totalRecovered = 0
        for country in countries {
            totalRecovered += country.recovered
        }
        
        return totalRecovered
    }
    
    private func getTotalDeaths(_ countries: [Country]) -> Int {
        var totalDeaths = 0
        for country in countries {
            totalDeaths += country.deaths
        }
        
        return totalDeaths
    }
    
    private func getRecoveredPercentage(_ countries: [Country]) -> Double {
        let totalConfirmed = Double(getTotalConfirmed(countries))
        let totalRecovered = Double(getTotalRecovered(countries))
        
        if totalConfirmed == 0 {
            return 0.0
        }
        
        return round(totalRecovered / totalConfirmed * 1000) / 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
