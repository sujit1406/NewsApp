//
//  NewsFeedController.swift
//  NewsApp
//
//  Created by Sujith Antony on 30/03/19.
//  Copyright © 2019 Sujith Antony. All rights reserved.
//

import UIKit

enum NewsFetchPeriod:String{
    case day = "1"
    case week = "7"
    case month = "30"
}


class NewsFeedController: UIViewController{
    
    @IBOutlet weak var presenter:NewsFeedPresenter!
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
            self.presenter.fetchNewsFeed(for:NewsFetchPeriod.day) {
                self.tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details",
            let nextScene = segue.destination as? NewsDetailsController ,
            let indexPath = self.tableView.indexPathForSelectedRow {

            guard let selectedItem = self.presenter.filteredTableData?[indexPath.row] as NewsFeedItem? else{
                return
            }
            nextScene.presenter.currentFeedItem = selectedItem
        }
    }
}
extension  NewsFeedController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "details", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175.0
    }
}





