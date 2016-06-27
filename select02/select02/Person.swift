//
//  Person.swift
//  Rotten Tomatoes
//
//  Created by Dang Quoc Huy on 6/27/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import Foundation

struct Person {
    var id: Int
    var name: String
    var height: Int
    var birthdate: String
    var pictureURL: NSURL
    
    init() {
        id = 0
        name = ""
        height = 0
        birthdate = ""
        pictureURL = NSURL(fileURLWithPath: "")
    }
    
    mutating func setData(data: NSDictionary) {
        if let id = data["id"] {
            self.id = id as! Int
        }
        if let name = data["name"] {
            self.name = String(name)
        }
        if let height = data["height"] {
            self.height = Int(height as! NSNumber)
        }
        if let birthdate = data["birthdate"] {
            self.birthdate = String(birthdate)
        }
        if let picture = data["picture"] {
            self.pictureURL = NSURL(string: String(picture))!
        }
    }
}
