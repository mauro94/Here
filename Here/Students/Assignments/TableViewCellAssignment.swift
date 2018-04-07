//
//  TableViewCellAssignment.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/6/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit

class TableViewCellAssignment: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var btComplete: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbCourse: UILabel!
    @IBOutlet weak var vColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
