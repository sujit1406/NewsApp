//
//  NewsDetailsPresenter.swift
//  NewsApp
//
//  Created by Sujith Antony on 30/03/19.
//  Copyright © 2019 Sujith Antony. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewsDetailsPresenter:NSObject{
    var currentFeedItem:NewsFeedItem?
    override init(){
        super.init()
    }

    func getDetailsImage(completion:@escaping (_ image: UIImage) -> Void){
        if let media = currentFeedItem?.media, let metadata = media.first?.mediaData{
        if(metadata.last != nil){
            if let url = metadata.last!.url{
            APIClient.getImage(url:url) { (image) in
                completion(image)
                }
            }
        }
        }
    }
    
    
}
