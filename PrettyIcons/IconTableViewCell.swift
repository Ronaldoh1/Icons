//
//  IconTableViewCell.swift
//  PrettyIcons
//
//  Created by Ronald Hernandez on 8/28/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class IconTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!

    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
