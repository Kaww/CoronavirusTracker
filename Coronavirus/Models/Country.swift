//
//  Country.swift
//  Coronavirus
//
//  Created by kaww on 25/02/2020.
//  Copyright © 2020 KAWRANTIN LE GOFF. All rights reserved.
//

import Foundation

class Country: NSObject, Codable {
    var country: String
    var longitude: Double
    var latitude: Double
    var confirmed: Int
    var recovered: Int
    var deaths: Int
    var lastUpdate: String
    
    init(country: String, longitude: Double, latitude: Double, confirmed: Int, recovered: Int, deaths: Int, lastUpdate: String) {
        self.country = country
        self.longitude = longitude
        self.latitude = latitude
        self.confirmed = confirmed
        self.recovered = recovered
        self.deaths = deaths
        self.lastUpdate = lastUpdate
    }
    
    var dump: String {
        get {
            return """
            --------------
            country: \(country)
            longitude: \(longitude)
            latitude: \(latitude)
            confirmed: \(confirmed)
            recovered: \(recovered)
            deaths: \(deaths)
            lastUpdate: \(lastUpdate)
            --------------
            """
        }
    }
}

struct FeaturesJSON: Codable {
    var features: [FeatureJSON]
}

struct FeatureJSON: Codable {
    var attributes: CountryJSON
}

struct CountryJSON: Codable {
    var Country_Region: String
    var Long_: Double
    var Lat: Double
    var Confirmed: Int
    var Recovered: Int
    var Deaths: Int
    var Last_Update: TimeInterval
}
