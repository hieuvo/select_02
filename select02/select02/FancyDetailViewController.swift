//
//  FancyDetailViewController.swift
//  select02
//
//  Created by hvmark on 6/27/16.
//  Copyright © 2016 hvmark. All rights reserved.
//

import UIKit

class FancyDetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var person: Person?
    
    override func viewWillAppear(animated: Bool) {
        setupData()
    }
    
    func setupData() {
        if let person = person {
            idLabel.text = String(person.id)
            heightLabel.text = String(person.height)
            birthdateLabel.text = person.birthdate
            nameLabel.text = person.name
            avatarImageView.setImageWithURL(person.pictureURL)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
