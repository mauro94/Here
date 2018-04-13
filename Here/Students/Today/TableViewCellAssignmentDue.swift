//
//  TableViewCellAssignmentDue.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/12/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit

class TableViewCellAssignmentDue: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var vColor: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbCourse: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
