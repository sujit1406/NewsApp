//
//  NewsFeedItem.swift
//  NewsApp
//
//  Created by Sujith Antony on 30/03/19.
//  Copyright © 2019 Sujith Antony. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class FeedResult:NSObject,Decodable{
    var status:String
    var num_results:Int
    var results:[NewsFeedItem]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case num_results = "num_results"
        case results = "results"
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        num_results = try container.decode(Int.self, forKey: .num_results)
        results = try container.decode([NewsFeedItem]?.self, forKey: .results)
    }
}



class NewsFeedItem:NSObject,Decodable,Comparable{
    static func < (lhs: NewsFeedItem, rhs: NewsFeedItem) -> Bool {
        guard let lhdate = lhs.publishedDate,let rhdate = rhs.publishedDate else{
            return false
        }
        return Common.dateFromString(string: lhdate) > Common.dateFromString(string:rhdate)
       // return lhs.id < rhs.id
    }
    var title:String? = ""
    var author:String? = ""
    var abstract:String? = ""
    var publishedDate:String? = ""
    var source:String? = ""
    var id:Int = 0
    var media:[Media]?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case author = "byline"
        case abstract = "abstract"
        case publishedDate = "published_date"
        case source = "source"
        case id = "id"
        case media = "media"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String?.self, forKey: .title)
        author = try container.decode(String?.self, forKey: .author)
        abstract = try container.decode(String?.self, forKey: .abstract)
        publishedDate = try container.decode(String?.self, forKey: .publishedDate)
        source = try container.decode(String?.self, forKey: .source)
        id = try container.decode(Int.self, forKey: .id)
        media = try container.decode([Media]?.self, forKey: .media)
    }
}

protocol PropertyReflectable { }

extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        for child in m.children {
            if child.label == key { return child.value }
        }
        return nil
    }
}

extension NewsFeedItem: PropertyReflectable{
    
}

class Media:NSObject,Decodable{
    var type:String? = ""
    var subType:String? = ""
    var caption:String? = ""
    var copyright:String? = ""
    var mediaData:[MediaData]? = []
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case subType = "subtype"
        case caption = "caption"
        case copyright = "copyright"
        case mediaData = "media-metadata"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String?.self, forKey: .type)
        subType = try container.decode(String?.self, forKey: .subType)
        caption = try container.decode(String?.self, forKey: .caption)
        copyright = try container.decode(String?.self, forKey: .copyright)
        mediaData = try container.decode([MediaData]?.self, forKey: .mediaData)
    }
}

class MediaData:NSObject,Decodable{
    var url:String? = ""
    var format:String? = ""
    var height:Int? = 0
    var width:Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case format = "format"
        case height = "height"
        case width = "width"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String?.self, forKey: .url)
        format = try container.decode(String?.self, forKey: .format)
        height = try container.decode(Int?.self, forKey: .height)
        width = try container.decode(Int?.self, forKey: .width)
    }
}
