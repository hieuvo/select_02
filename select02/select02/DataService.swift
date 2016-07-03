//
//  DataService.swift
//  select02
//
//  Created by hvmark on 7/1/16.
//  Copyright © 2016 hvmark. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataService {
    var url: String = "https://fancy-raptor.hyperdev.space/"
    
    func buildUrlString(offset: Int?, limit: Int?) -> String {
        var params = [String]()
        
        if offset != nil { params.append("offset=" + String(offset!)) }
        if limit != nil { params.append("limit=" + String(limit!)) }
        
        if params.count > 0 {
            return self.url + "?" + params.joinWithSeparator("&")
        } else {
            return self.url
        }
    }
    
    func loadData(offset: Int?, limit: Int?, completeHandler: (JSON) -> Void ) -> Void {
        let request = NSURLRequest(URL: NSURL(string: buildUrlString(offset, limit: limit))!)
        let session = NSURLSession.sharedSession()
        
        print ("Start loading")
        
        let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            guard error == nil else  {
                print("error loading from URL", error!)
                return
            }
            
            guard data != nil else {
                print("null data")
                return
            }
            
            let jsonData = JSON(data: data!)
            
            print ("finsh loading")
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completeHandler(jsonData)
            })
        }
        task.resume()
    }
    
}
