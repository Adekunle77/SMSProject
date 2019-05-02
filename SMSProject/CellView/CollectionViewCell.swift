//
//  CollectionViewCell.swift
//  SMSProject
//
//  Created by Ade Adegoke on 24/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var dateTexted: UILabel!
    @IBOutlet weak var timeTexted: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
