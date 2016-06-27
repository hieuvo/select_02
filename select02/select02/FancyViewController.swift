//
//  FancyViewController.swift
//  select02
//
//  Created by Dang Quoc Huy on 6/27/16.
//  Copyright © 2016 hvmark. All rights reserved.
//

import UIKit

class FancyViewController: UIViewController {

    var persons: [Person]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        
        let url = NSURL(string: "https://fancy-raptor.hyperdev.space/")!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            guard error == nil else  {
                print(error)
                return
            }
            
            do {
                // parse response data
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary {
                    let datas = json[""] as! [NSDictionary]
                    for data in datas {
                        var person = Person()
                        person.setData(data)
                        self.persons?.append(person)
                    }
                    // reload table from main thread
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }
            } catch {
                // TODO: handle error
            }
        }
        dataTask.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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