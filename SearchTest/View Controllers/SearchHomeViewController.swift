//
//  SearchHomeViewController.swift
//  SearchTest
//
//  Created by Adam Parker on 12/05/2020.
//  Copyright © 2020 Adam Parker. All rights reserved.
//

import UIKit
import CoreData

class SavedSearchCell : UITableViewCell {
    @IBOutlet weak var cellLabel : UILabel?
}

class SearchHomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var savedSearchCell : SavedSearchCell?
    @IBOutlet weak var searchTextfield: UITextField!
    var tableviewDataSource : [SavedSearchItem] = [SavedSearchItem]()
    
    var loadingOverlay : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchTextfield.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //fetchData()
        tableviewDataSource.removeAll()
        tableviewDataSource = CoreDataController.sharedInstance.readData()
        tableView.reloadData()
    }
    
    @IBAction func SearchRepos(_ sender: Any) {
        
        if searchTextfield.text != ""
        {
            // Search based on what the user has entered into the textfied.
            fetchRepo(searchText: searchTextfield.text!)
        }
        else
        {
            //alert user textfield is empty
            self.showNoMatch(alertText: "Search field cannot be empty.")
        }
        
    }
    
}

extension SearchHomeViewController
{
    func fetchRepo(searchText: String)
    {
        self.showLoadingIndicator()
        // If we do not trim the string the API call will not return anything.
        let trimmedString = searchText.replacingOccurrences(of: " ", with: "")
        
        // Search for the repos by the trimmed string.
        RepoAPI.sharedInstance.searchRepos(name: trimmedString, completion: {(response : SearchRepoResponse? , error : Error?) in
            
            if response != nil
            {
                if (response?.totalCount)! > 0
                {
                    // Save item when we know the search has successfully returned values
                    CoreDataController.sharedInstance.saveItem(searchText)
                    
                    let MainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let searchListVC =  MainStoryboard.instantiateViewController(withIdentifier: "SearchListViewController") as? SearchListViewController
                    searchListVC?.repoItemArray = response?.items
                    
                    self.navigationController?.pushViewController(searchListVC!, animated: true)
                }
                else
                {
                    //alert user no matches
                    self.showNoMatch(alertText: "No repos match your search criteria")
                }
            }
            self.loadingOverlay?.removeFromSuperview()
            
        })
    }
    
    func showLoadingIndicator()
    {
        // I would change this personally to something more appealing i do not like the built in activity indicator, this will do for what we need it for. As it is just reference for the user that something is happening on screen when searching.
        
        loadingOverlay = UIView(frame: view.frame)
        loadingOverlay?.backgroundColor = .gray
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = loadingOverlay!.center
        activityIndicator.startAnimating()
        
        loadingOverlay?.addSubview(activityIndicator)
        view.addSubview(loadingOverlay!)
    }
    
    func showNoMatch(alertText : String)
    {
        // Alert for no match this could really go into one function and based on a Bool for example would differentciate between the loading alert and this one. This was just more readble in this senario.
        let alert = UIAlertController(title: nil, message: alertText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SearchHomeViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // here you can set the return button to hide the keyboard, it is also possible to have the return button search after being clicked.
        textField.resignFirstResponder()
        return true
    }
}

extension SearchHomeViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get the tableview data source count here it is optional so not need for an optional ?? as you will see is different in the other screen.
        return tableviewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Here we get the saved search cell if we have anything to populate the tableview itself.
        savedSearchCell = (tableView.dequeueReusableCell(withIdentifier: "SavedSearchCell") as! SavedSearchCell)
        savedSearchCell?.selectionStyle = UITableViewCell.SelectionStyle.none
        
        // We will get the text based on the indexpath of the row, which we will get from the data source itself.
        savedSearchCell?.cellLabel?.text =  tableviewDataSource[indexPath.row].searchText
        
        return savedSearchCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Check there is a data source before allowing selection of a cell, this would otherwise cause a crash.
        if tableviewDataSource.count != 0
        {
            // Search based on the saved search section.
            fetchRepo(searchText: self.tableviewDataSource[indexPath.row].searchText)
        }
        
    }
    
}
