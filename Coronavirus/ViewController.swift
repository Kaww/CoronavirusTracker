//
//  ViewController.swift
//  Coronavirus
//
//  Created by kaww on 25/02/2020.
//  Copyright © 2020 KAWRANTIN LE GOFF. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {

    let cellID = "cellID"
    let headerID = "headerID"
    let footerID = "footerID"
    
    var countries = [Country]()
    var filteredCountries = [Country]()
    var isLoading = false {
        didSet {
            if isLoading {
                searchController.searchBar.isUserInteractionEnabled = false
                navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                searchController.searchBar.isUserInteractionEnabled = true
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    
    var lastUpdate: String?
    
    let searchController = UISearchController(searchResultsController: nil)
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Coronavirus"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showRoadMap))
        
        setupSearchController()
        setupCollectionView()
        setupActivityIndicator()
        getSavedData()
        loadData(withIndicator: true)
    }

    
    // MARK: -- SETUP METHODS
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a country"
        navigationItem.searchController = searchController
    }
    
    private func setupCollectionView() {
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: headerID)
        collectionView.register(FooterCell.self, forCellWithReuseIdentifier: footerID)
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    private func toggleActivityIndicator() {
        isLoading = !isLoading
        activityIndicator.isAnimating ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
    }
    
    
    // MARK: -- CLASS METHODS
    
    func loadData(withIndicator showIndicator: Bool) {
        if showIndicator {
            toggleActivityIndicator()
        }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.countries = CoronavirusAPI.getCountries()
            
            // - - - - - - - - - - - - - - - - - \
            // TODO: FIX DA SCROLLING SHITTY BUG |
            // ---------------------------------/
            //        filteredCountries = [
            //            countries[1],
            //            countries[2],
            //            countries[3],
            //            countries[4]
            //        ]
            // ---------------------------------
            if let countries = self?.countries { self?.filteredCountries = countries }
            if let date = CoronavirusAPI.lastUpdateDate {
                self?.lastUpdate = date
            }
            self?.saveData()
            
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                if showIndicator {
                    self?.toggleActivityIndicator()
                }
            }
        }
    }
    
    func getSavedData() {
        let defaults = UserDefaults.standard
        
        if let date = defaults.string(forKey: "lastUpdateDate") {
            lastUpdate = date
        }
        
        if let savedCountries = defaults.object(forKey: "countries") as? Data {
            let decoder = JSONDecoder()

            do {
                countries = try decoder.decode([Country].self, from: savedCountries)
                filteredCountries = countries
                collectionView.reloadData()
            } catch {
                print("Failed to load people.")
            }
        }
    }
    
    func saveData() {
        let defaults = UserDefaults.standard
        
        defaults.set(CoronavirusAPI.lastUpdateDate, forKey: "lastUpdateDate")
        
        let jsonEncoder = JSONEncoder()
        
        if let data = try? jsonEncoder.encode(countries) {
            defaults.set(data, forKey: "countries")
        } else {
            print("Failed to save people data.")
        }
    }
    
    @objc func refresh() {
        loadData(withIndicator: true)
    }

    @objc func showRoadMap() {
        let message = """

            - [x]  Header with sums of each displayed countries

            - [ ]  Fix scrolling bug on search

            - [x]  Add API sources (at the buttom of the screen ?)

            - [x] Country view with map and informations + last update date

            - [ ] Refresh in background

            - [ ] Add notifications if country overpass amount of confirmed or deaths

            - [ ] Fix Cells constraints (bug when changing orientation)

            - [ ] Manage dark and white mode

            - [x] Load data in background + add loader

            - [x] User defaults for offline mode
        """
        let ac = UIAlertController(title: "Road map 🗺", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "🔥", style: .default))
        
        present(ac, animated: true)
    }
    
    private func filterCountriesBy(name: String) {
        var list = [Country]()
        
        if name.count != 0 {
            for country in countries {
                if country.country.lowercased().contains(name.lowercased()) {
                    list.append(country)
                }
            }
            filteredCountries = list
        } else {
            filteredCountries = countries
        }
        
        collectionView.reloadData()
    }

    
    // MARK: -- COLLECTION VIEW DELEGATES
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Header
        if section == 0 || section == 2 {
            return 1
        }
        
        // Country
        return filteredCountries.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Header
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableCell(withReuseIdentifier: headerID, for: indexPath) as! HeaderCell
            header.countries = filteredCountries
            header.lastUpdate = lastUpdate
            return header
        } else if indexPath.section == 2 {
            let footer = collectionView.dequeueReusableCell(withReuseIdentifier: footerID, for: indexPath) as! FooterCell
            return footer
        }
        
        // Country
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CountryCell
        cell.country = filteredCountries[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 20
        let height = width * 0.3
        
        if indexPath.section == 0 {
            return .init(width: width, height: height * 0.75)
        } else if indexPath.section == 1 {
            return .init(width: width, height: height)
        }
        return .init(width: width * 0.75, height: height * 0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .init(top: 20, left: 0, bottom: 20, right: 0)
        } else if section == 1 {
            return .init(top: 20, left: 0, bottom: 40, right: 0)
        }
        return .init(top: 15, left: 0, bottom: 10, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = CountryViewController()
            vc.country = filteredCountries[indexPath.item]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    // MARK: -- SEARCH RESULTS UPDATER DELEGATES
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterCountriesBy(name: text)
    }
}

