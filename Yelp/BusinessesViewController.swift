//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {

    var businesses: [Business]!
    var filteredBusinesses: [Business]?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "Restaurants"
        navigationItem.titleView = searchBar
        searchBar.delegate = self

        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: nil, deals: nil, distance: nil) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filtered = filteredBusinesses {
            return filtered.count
        } else if let unfiltered = businesses {
            return unfiltered.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        if let filtered = filteredBusinesses {
            cell.business = filtered[indexPath.row]
        } else {
            cell.business = businesses[indexPath.row]
        }
        
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        var categories = filters["categories"] as? [String]
        var deals = filters["deals"] as? Bool
        let sort = sortMode(filters["sort"] as! Int)
        
        var distance = filters["distance"] as? Double
        Business.searchWithTerm("Restaurants", sort: sort, categories: categories, deals: deals, distance: distance, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        })
    }
    
    func sortMode(index: Int) -> YelpSortMode {
        switch index {
        case 0:
            return YelpSortMode.BestMatched
        case 1:
            return YelpSortMode.Distance
        case 2:
            return YelpSortMode.HighestRated
        default:
            assert(false)
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filterRestaurantsWithText(searchText)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        filteredBusinesses = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func filterRestaurantsWithText(searchText: String) {
        if searchText != "" {
            filteredBusinesses = [Business]()
            for business in businesses {
                if business.name!.lowercaseString.rangeOfString(searchText.lowercaseString) != nil {
                    filteredBusinesses!.append(business)
                }
            }
        } else {
            filteredBusinesses = nil
        }

        
        tableView.reloadData()
    }
}
