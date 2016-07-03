//
//  FancyViewController.swift
//  select02
//
//  Created by Dang Quoc Huy on 6/27/16.
//  Copyright © 2016 hvmark. All rights reserved.
//

import UIKit
import SwiftyJSON
//import Fabric
import Crashlytics
//import Answers
import Optimizely

class FancyViewController: UIViewController {

    var persons: [Person] = []
    let dataService = DataService()
    
    @IBOutlet weak var tableView: UITableView!
    internal var messageKey =
        OptimizelyVariableKey.optimizelyKeyWithKey("message", defaultNSString: "Hello World!")
//    internal var messageKey =
//        OptimizelyVariableKey.optimizelyKeyWithKey("numberOfItemsPerLoadMore", defaultNSString: "2")
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
//        loadDataFromLocalFile()
        
        let messageButton = UIButton(type: UIButtonType.System)
        messageButton.setTitle("Show Message", forState: UIControlState.Normal)
        messageButton.addTarget(self, action: #selector(self.showMessage(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        messageButton.frame = CGRectMake(25, 60, 200, 50)
        view.addSubview(messageButton)

        
    }
    
    @IBAction func showMessage(sender: AnyObject) {
        let alert = UIAlertController(title: "Live Variable",
                                      message: Optimizely.stringForKey(messageKey),
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: nil))
        presentViewController(alert, animated: true) {}
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func showAlert() {
        let alertController = UIAlertController(title: "Empty data", message: "We cannot load more data", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertController.addAction(OKAction)
        
        presentViewController(alertController, animated: false, completion: nil)
    }
    
   
    func loadData(offset: Int = 0, limit: Int = 2, resetData: Bool = true) {
        if resetData {
            persons = []
        }
        
        dataService.loadData(offset, limit: limit) { (jsonData: JSON) in
            if jsonData.count == 0 {
                self.showAlert()
                print ("out of data")
                return
            }
            
            for (_,p):(String, JSON) in jsonData {
                let person = Person(data: p)
                self.persons.append(person)
            }

            self.tableView.reloadData()
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.persons.count - 1, inSection: 0), atScrollPosition: .Bottom, animated: true)
        }
    }
    
    var clickCount = 0
    var firstClick: NSDate?
    

    
    func loadMore(limit: Int = 2) {
        
        clickCount += 1
        var timeFromFirstClick = 0
        if firstClick == nil {
            firstClick = NSDate()
        } else {
            timeFromFirstClick = Int(NSDate().timeIntervalSinceDate(firstClick!))
        }
        
        Answers.logCustomEventWithName("clicked_load_more", customAttributes: ["click_count": clickCount, "time_from_first_click": timeFromFirstClick])
        
        loadData(persons.count, limit: limit, resetData: false)
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! FancyDetailViewController
        let indexPath = tableView.indexPathForCell(sender as! FancyCell)!
        vc.person = persons[indexPath.row]
    }
    
    // MARK: - Actions
    
    @IBAction func onLoadMore(sender: AnyObject) {
        loadMore()
    }
    
}

extension FancyViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FancyCell") as! FancyCell
        cell.person = persons[indexPath.row]
        
        if cell.person.isEmpty {
            cell.userInteractionEnabled = false
        }
        
        return cell
    }
}

extension FancyViewController: UITableViewDelegate {
    
}