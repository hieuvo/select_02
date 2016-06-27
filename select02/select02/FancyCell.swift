//
//  FancyCell.swift
//  select02
//
//  Created by Dang Quoc Huy on 6/27/16.
//  Copyright © 2016 hvmark. All rights reserved.
//

import UIKit
import AFNetworking

class FancyCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var person: Person! {
        didSet {
            nameLabel.text = person.name
            avatarImageView.setImageWithURL(person.pictureURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
