//
//  SegmentedControlCell.swift
//  Yelp
//
//  Created by Sam Sweeney on 9/27/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SegmentedControlCellDelegate {
    optional func segmentedControlCell(segmentedControlCell: SegmentedControlCell, selectedIndex value:Int)
}

class SegmentedControlCell: UITableViewCell {

    var delegate: SegmentedControlCellDelegate?
    
    @IBAction func segmentedControlChanged(sender: AnyObject) {
        delegate?.segmentedControlCell?(self, selectedIndex: segmentedControl.selectedSegmentIndex)
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
