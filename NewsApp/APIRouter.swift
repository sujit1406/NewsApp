//
//  APIRouter.swift
//  NewsApp
//
//  Created by Sujith Antony on 30/03/19.
//  Copyright © 2019 Sujith Antony. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case getPopularNewsFeed(period:String)
    case getImage(url:String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .getPopularNewsFeed(period:), .getImage(url:):
            return .get
        }
    }
    private var path: String {
        switch self {
        case .getPopularNewsFeed(let period):
            return "mostpopular/v2/viewed/\(period).json"
        case .getImage(let url):
            return url
    }
    }
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let baseurl = try K.ProductionServer.baseURL.asURL()
        let completeurl = baseurl.appendingPathComponent(path)
        let parameters:Parameters = ["api-key":nytAppKey]
        var urlRequest = URLRequest(url:completeurl)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }

}
