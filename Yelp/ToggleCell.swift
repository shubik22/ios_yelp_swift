//
//  ToggleCell.swift
//  Yelp
//
//  Created by Sam Sweeney on 9/26/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol ToggleCellDelegate {
    optional func toggleCell(toggleCell: ToggleCell)
}

class ToggleCell: UITableViewCell {

    var delegate: ToggleCellDelegate?
    
    @IBOutlet weak var toggleButton: UIButton!
    @IBAction func toggleButtonClicked(sender: AnyObject) {
        delegate?.toggleCell?(self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitle(title: String) {
        toggleButton.titleLabel?.text = title
    }
    
}
