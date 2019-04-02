//
//  OnlineSearchPresenter.swift
//  NewsApp
//
//  Created by Sujith Antony on 30/03/19.
//  Copyright © 2019 Sujith Antony. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreData

protocol SearchResultsProtocol:class{
    func didFinishLoadingResults()
}
let imageCache = NSCache<AnyObject, AnyObject>()

class NewsFeedPresenter:NSObject,UISearchControllerDelegate{
    var filteredTableData :[NewsFeedItem]?
    var localTableData :[NewsFeedItem]?
    override init(){
        super.init()
    }
    
    func fetchNewsFeed(for period:NewsFetchPeriod,completion:@escaping ()->Void){
        APIClient.getPopularNewsFeed(period:period.rawValue) { newsFeed in
            if let list = newsFeed.value as FeedResult?, let results = list.results{
                self.filteredTableData?.removeAll()
                self.filteredTableData = nil
                self.filteredTableData = results.sorted()
                completion()
            }
        }
    }
}

extension NewsFeedPresenter:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsFeedCell = tableView.dequeueReusableCell(withIdentifier: newsCellIdentifier, for:indexPath) as! NewsFeedCell
        
        guard let newsfeed = filteredTableData?[indexPath.row] else{
            return cell
        }
        
        if let title = newsfeed.title{
            cell.titleLabel.text = title
        }
        
        if let date = newsfeed.publishedDate{
            cell.dateLabel.text = date
        }
        
        if let author = newsfeed.author{
            cell.authorLabel.text = author
        }
        
        if let imageurl = newsfeed.media?.first?.mediaData?.first?.url{
            if let imageFromCache = imageCache.object(forKey: imageurl as AnyObject) as? UIImage{
                cell.photoImage.image = imageFromCache
            }else{
                APIClient.getImage(url: imageurl) { (image) in
                    imageCache.setObject(image as AnyObject, forKey: imageurl as AnyObject)
                        cell.photoImage.image = image
                }
            }
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTableData?.count ?? 0
    }

}


