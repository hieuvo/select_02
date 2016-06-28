//
//  Person.swift
//  Rotten Tomatoes
//
//  Created by Dang Quoc Huy on 6/27/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Person {
    var id: Int = 0
    var name: String = ""
    var height: Int = 0
    var birthdate: String = ""
    var pictureURL: NSURL = NSURL()
    
    init() {
        id = 0
        name = ""
        height = 0
        birthdate = ""
        pictureURL = NSURL(fileURLWithPath: "")
    }
    
    mutating func setData(data: JSON) {
        id = Int(data["id"].stringValue)!
        name = data["name"].stringValue
        height = Int(data["height"].stringValue)!
        
        birthdate = data["birthdate"].stringValue
        pictureURL = NSURL(string: String(data["picture"].stringValue))!
    }
}
