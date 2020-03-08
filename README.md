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

See *@objc private func animateCollectionView()* in file *./viewController.swift*

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

...

## SearchBar using UISearchController

...

## MapView from MapKit

...
