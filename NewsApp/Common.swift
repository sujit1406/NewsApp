//
//  Common.swift
//  NewsApp
//
//  Created by Sujith Antony on 01/04/19.
//  Copyright © 2019 Sujith Antony. All rights reserved.
//

import Foundation

class Common{
    static func dateFromString(string:String) -> Date{
        let isoDate = string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:isoDate)!
        return date
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}




