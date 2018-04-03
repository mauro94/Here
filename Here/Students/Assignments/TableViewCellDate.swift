//
//  TableViewCellDate.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/28/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit

class TableViewCellDate: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var lbSelectedDate: UILabel!
    @IBOutlet weak var dpDate: UIDatePicker!
    @IBOutlet weak var btTomorrow: UIButton!
    @IBOutlet weak var btDays: UIButton!
    @IBOutlet weak var btNextWeek: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Button design
        btTomorrow.layer.cornerRadius = 8.0
        btDays.layer.cornerRadius = 8.0
        btNextWeek.layer.cornerRadius = 8.0
        
        // Add text to label
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM-dd"
        
        lbSelectedDate.text = formatter.string(from: date)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
