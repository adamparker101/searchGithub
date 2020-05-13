//
//  SearchMoreInfoViewController.swift
//  SearchTest
//
//  Created by Adam Parker on 12/05/2020.
//  Copyright © 2020 Adam Parker. All rights reserved.
//

import UIKit
import CoreData
// We can do this in two ways this way for this specific vc allows us not to have to create a whole new class just for the tableview cell.
class RepoSearchMoreInfoItemCell : UITableViewCell {
    
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var lastPushLabel: UILabel!
    
}

class SearchMoreInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var repoCell : RepoSearchItemCell?
    var repoMoreInfoCell : RepoSearchMoreInfoItemCell?
    var moreInfoRepoItem : SearchRepoItem?
    
    private var baseIndexPath : Int = 0
    private var tableViewRows : Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    
}

extension SearchMoreInfoViewController:  UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableViewRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == baseIndexPath
        {
            repoCell = (tableView.dequeueReusableCell(withIdentifier: "RepoSearchItemCell") as! RepoSearchItemCell)
            repoCell?.selectionStyle = UITableViewCell.SelectionStyle.none
            
            repoCell?.cellLabel?.text =  moreInfoRepoItem?.name ?? ""
            repoCell?.cellDescriptionLabel?.text = moreInfoRepoItem?.description ?? ""
            
            return repoCell!
        }
        else
        {
            repoMoreInfoCell = (tableView.dequeueReusableCell(withIdentifier: "RepoSearchMoreInfoItemCell") as! RepoSearchMoreInfoItemCell)
            repoMoreInfoCell?.selectionStyle = UITableViewCell.SelectionStyle.none
            
            repoMoreInfoCell?.forkLabel?.text = "Fork count: \(moreInfoRepoItem?.forks_count ?? 0)"
            repoMoreInfoCell?.urlLabel?.text = "Full URL: \(moreInfoRepoItem?.url ?? "")"
            repoMoreInfoCell?.lastPushLabel?.text = "Last pushed: \(moreInfoRepoItem?.pushed_at ?? "")"
            repoMoreInfoCell?.lastUpdateLabel?.text = "Last updated: \( moreInfoRepoItem?.updated_at ?? "")"
            
            return repoMoreInfoCell!
        }
        
    }
    
}
