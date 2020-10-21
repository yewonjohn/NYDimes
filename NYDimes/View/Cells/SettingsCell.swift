//
//  SettingsCellTableViewCell.swift
//  NYDimes
//
//  Created by John Kim on 10/19/20.
//

import UIKit

class SettingsCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsImage: UIImageView!
    
    //MARK:- Propeties

    static let identifier = "SettingsCell"

    //MARK:- LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
