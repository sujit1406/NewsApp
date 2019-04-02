//
//  Constants.swift
//  NewsApp
//
//  Created by Sujith Antony on 30/03/19.
//  Copyright © 2019 Sujith Antony. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "http://api.nytimes.com/svc/"
    }

}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

let nytAppKey = "dAu2Z2hsbnANANcEZLPhs2GktQAnKiTX"

