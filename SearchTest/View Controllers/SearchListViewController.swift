//
//  SearchListViewController.swift
//  SearchTest
//
//  Created by Adam Parker on 12/05/2020.
//  Copyright © 2020 Adam Parker. All rights reserved.
//

import UIKit


class RepoSearchItemCell : UITableViewCell {
    @IBOutlet weak var cellLabel : UILabel?
    @IBOutlet weak var cellDescriptionLabel: UILabel!
}

class SearchListViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    var repoCell : RepoSearchItemCell?
    var repoItemArray : [SearchRepoItem]? = [SearchRepoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // Navigate and pass over the more information object, can use segues as well, this is just how i have done it before.
    func navigationToMoreInformation(moreInfoItem : SearchRepoItem)
    {
        let MainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let moreInfoVC =  MainStoryboard.instantiateViewController(withIdentifier: "SearchMoreInfoViewController") as? SearchMoreInfoViewController
        moreInfoVC?.moreInfoRepoItem = moreInfoItem
        
        self.navigationController?.pushViewController(moreInfoVC!, animated: true)
    }
    

}


extension SearchListViewController:  UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If optional array then we will put in the optional value of 0, this would therefore not cause a crash if we have no values in the array to populate the tableview. Just two different ways showing how optionals work.
        return repoItemArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        repoCell = (tableView.dequeueReusableCell(withIdentifier: "RepoSearchItemCell") as! RepoSearchItemCell)
        repoCell?.selectionStyle = UITableViewCell.SelectionStyle.none
        
        repoCell?.cellLabel?.text =  repoItemArray![indexPath.row].name ?? ""
        repoCell?.cellDescriptionLabel?.text = repoItemArray![indexPath.row].description ?? ""
        
        return repoCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // we do this based on if there is anything for the user to click
        if(repoItemArray?.count != 0)
        {
            navigationToMoreInformation(moreInfoItem: (self.repoItemArray?[indexPath.row])!)
        }
    }

}
