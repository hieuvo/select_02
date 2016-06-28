//
//  FancyViewController.swift
//  select02
//
//  Created by Dang Quoc Huy on 6/27/16.
//  Copyright © 2016 hvmark. All rights reserved.
//

import UIKit
import SwiftyJSON

class FancyViewController: UIViewController {

    var persons: [Person]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
//        loadDataFromLocalFile()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func loadDataFromLocalFile() {
//        print ("Start loading from local file")
//        
//        let path = NSBundle.mainBundle().pathForResource("data", ofType:"json")
//        let dataJson = NSData(contentsOfFile: path!)
//        let data = try! NSJSONSerialization.JSONObjectWithData(dataJson!, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
//
//        
//        self.persons = []
//        for p in data {
//            var person = Person()
//            person.setData(p)
//            self.persons?.append(person)
//        }
//        
//        tableView.reloadData()
//    }
    
    func buildUrl(offset: Int? = nil, limit: Int? = nil) -> String {
        if offset == nil && limit == nil {
            return "https://fancy-raptor.hyperdev.space/"
        }
        
        
        return ""
    }
    
    func loadData() {
        
        let url = NSURL(string: buildUrl())!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        print ("Start loading")
        
        
        
        let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            guard error == nil else  {
                print("error loading from URL", error!)
                return
            }
            
            let jsonData = JSON(data: data!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.persons = []
                
                for (_,p):(String, JSON) in jsonData {
                    var person = Person()
                    person.setData(p)
                    self.persons?.append(person)
                }
                
                self.tableView.reloadData()
            })
        }
        
        task.resume()
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! FancyDetailViewController
        let indexPath = tableView.indexPathForCell(sender as! FancyCell)!
        vc.person = persons![indexPath.row]
    }
    
    
    @IBAction func onLoadMore(sender: AnyObject) {
        print ("load more")
    }
    
}

extension FancyViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FancyCell") as! FancyCell
        cell.person = persons![indexPath.row]
        
        return cell
    }
}

extension FancyViewController: UITableViewDelegate {
    
}