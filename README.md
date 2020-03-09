# CoronavirusTracker

This app displays informations about the COVID-19 Virus for each concerned country.

Based on [this website](https://gisanddata.maps.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6), data is provided by Johns Hopkins University. [See data](https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/1/query?f=json&where=Confirmed%20%3E%200&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&orderByFields=Confirmed%20desc%2CCountry_Region%20asc%2CProvince_State%20asc&outSR=102100&resultOffset=0&resultRecordCount=250&cacheHint=true).

This application is for educational purpose.

Here are the list of all the feature implemented in the app.
All the app have been made using code only. No storyboards.

## NavigationController programmatically

...

## Constraints by code

...

## CollectionView & custom cells

...

## CollectionView animations

In file *./viewController.swift*, check :

```swift
@objc private func animateCollectionView()
```

## Requests & JSON Data managment

### Request

Requests can be very easily done. Here I'm requesting an URL that return JSON data. Here is how it's done :

-> *Managers/CoronavirusAPI.swift*

```swift
if let url = URL(string: endpoint) {
    if let data = try? Data(contentsOf: url) {
        // do some stuff...
    }
}
```

### JSON Parsing

...

## Pull-to-refresh control

Adding a *pull-to-refresh* feature to a **collectionView** or **tableView** is very simple.

First, add the **UIRefreshControl** to your **viewController**:

```swift
let refreshControl = UIRefreshControl()
```

In the **viewDidLoad** method, setup the target action and add the **refreshControl** to the **collectionView/tableView**:

```swift
refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
collectionView.refreshControl = refreshControl
```

The refresh method should be like this:

```swift
@objc func refresh() {
    // refresh stuff...
}
```

When the refresh action is done, stop the refreshing by adding:

```swift
@objc func refresh() {
    // refresh stuff...
    // ...
    
    refreshControl.endRefreshing()
}
```


## Manage background tasks

// To be implemented

## Fire background notifications

// To be implemented

## Save data on device

For saving data on device, I'm using **UserDefaults**. This allows to encode data, and write it into the device. Then, it allows to find it back, using the associated key.

### Write data on device

Here is how I'm using **UserDefaults** to write the data :

To write simple data, like numbers or strings, you can use

```swift
defaults.set("June 29, 2007", forKey: "lastUpdateDate")
```

To write more complex data like a class, the class need to implement the **Codable** protocol :

```swift
class Country: NSObject, Codable {
    ...
}
```

Then, the object can be encoded in JSON and saved as follow :

```swift
let jsonEncoder = JSONEncoder()

if let data = try? jsonEncoder.encode(country) {
    defaults.set(data, forKey: "country")
} else {
    print("Failed to save country.")
}
```

### Load data from device

Loading data is also very simple.

To load simple data, you can use :

```swift
guard let date = defaults.string(forKey: "lastUpdateDate") else { ... }
```

To load more complex data, the data need to be decoded from JSON to the object class :

```swift
if let savedCountry = defaults.object(forKey: "country") as? Data {
    let decoder = JSONDecoder()

    do {
        country = try decoder.decode(Country.self, from: savedCountry)
        ...
    } catch {
        print("Failed to load country.")
    }
}
```

## SearchBar using UISearchController

The easiest way to search through your cells in a **collectionView** or **tableView** is by using **UISearchController**.

```swift
let searchController = UISearchController(searchResultsController: nil)
```

Your **viewController** need to implement the **UISearchResultsUpdating** protocol.

Then, you have to setup the searchController and assign it to the navigationController in order to add the searchBar on it.

```swift
searchController.searchResultsUpdater = self
searchController.obscuresBackgroundDuringPresentation = false
navigationItem.searchController = searchController
```

Finally, thank's to the **UISearchResultsUpdating** protocol, you can implement the following delegate, that will be called each time the content of the searchBar's text field is modified :

```swift
func updateSearchResults(for searchController: UISearchController) {
    guard let text = searchController.searchBar.text else { return }
    ...
    // filter collectionView or tableView, and reload it
}
```

## MapView from MapKit

...
