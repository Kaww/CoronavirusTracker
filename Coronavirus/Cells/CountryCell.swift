//
//  CountryCollectionViewCell.swift
//  Coronavirus
//
//  Created by kaww on 25/02/2020.
//  Copyright © 2020 KAWRANTIN LE GOFF. All rights reserved.
//

import UIKit

class CountryCell: UICollectionViewCell {
    
    private var countryLabel = UILabel()
    private var confirmedLabel = UILabel()
    private var recoveredLabel = UILabel()
    private var deathsLabel = UILabel()
    
    var country : Country? {
        didSet {
            if let country = country {
                countryLabel.text = country.country
                confirmedLabel.text = "🤒 \(country.confirmed)"
                recoveredLabel.text = "😀 \(country.recovered)"
                deathsLabel.text = "☠️ \(country.deaths)"
                
                backgroundColor = ColorManager.getColorFrom(infected: country.confirmed)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabels()
        setupLabelsConstraints()
        setupRightImage()
        
        backgroundColor = .darkGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 15
    }
    
    private func setupLabels() {
        countryLabel.text = "..."
        countryLabel.font = .systemFont(ofSize: 20, weight: .medium)
        countryLabel.textColor = .white
        addSubview(countryLabel)
        
        confirmedLabel.text = "🤒 ..."
        confirmedLabel.font = .systemFont(ofSize: 13)
        confirmedLabel.textColor = .white
        confirmedLabel.textAlignment = .center
        
        recoveredLabel.text = "😀 ..."
        recoveredLabel.font = .systemFont(ofSize: 13)
        recoveredLabel.textColor = .white
        recoveredLabel.textAlignment = .center
        
        deathsLabel.text = "☠️ ..."
        deathsLabel.font = .systemFont(ofSize: 13)
        deathsLabel.textColor = .white
        deathsLabel.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [confirmedLabel, recoveredLabel, deathsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        setupStackViewConstraints(stackView: stackView)
    }
    
    private func setupLabelsConstraints() {
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        countryLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: frame.height / 3).isActive = true
    }
    
    private func setupStackViewConstraints(stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height * 3 / 5).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
    }
    
    private func setupRightImage() {
        if let image = UIImage(named: "caret") {
            let tintableImage = image.withRenderingMode(.alwaysTemplate)
            let imageView = UIImageView(image: tintableImage)
            imageView.tintColor = .white
            addSubview(imageView)
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
