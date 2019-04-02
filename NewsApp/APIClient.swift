//
//  APIClient.swift
//  NewsApp
//
//  Created by Sujith Antony on 30/03/19.
//  Copyright © 2019 Sujith Antony. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return Alamofire.request(route)
            .responseData{ response in
                let result : Result<T> = decoder.decodeResponse(from: response)
                    completion(result)}
    }
    
    static func getPopularNewsFeed(period:String,completion:@escaping (Result<FeedResult>)->Void){
        performRequest(route: APIRouter.getPopularNewsFeed(period: period), completion: completion)
    }
    
    static func getImage(url:String,completion:@escaping (UIImage)->Void){
        Alamofire.request(url, method: .get, parameters: nil).response { response in
            if let data = response.data {
                if let image = UIImage(data: data){
                completion(image)
                }
            }
        }
    }
}


extension JSONDecoder {
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }
        
        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure(response.error!)
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            print("error trying to decode response")
            print(error)
            return .failure(error)
        }
    }
}

