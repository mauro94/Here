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

    @IBAction func pressedDateButton(_ sender: UIButton) {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM-dd"
        
        switch sender {
            case btTomorrow:
                let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
                dpDate.date = tomorrow!
                lbSelectedDate.text = formatter.string(from: tomorrow!)
            case btDays:
                let days = Calendar.current.date(byAdding: .day, value: 3, to: today)
                dpDate.date = days!
                lbSelectedDate.text = formatter.string(from: days!)
            default:
                let week = Calendar.current.date(byAdding: .day, value: 7, to: today)
                dpDate.date = week!
                lbSelectedDate.text = formatter.string(from: week!)
            }
        }
}
