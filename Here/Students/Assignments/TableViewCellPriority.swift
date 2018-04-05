//
//  TableViewCellPriority.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/28/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit

class TableViewCellPriority: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var btHigh: UIButton!
    @IBOutlet weak var btNormal: UIButton!
    @IBOutlet weak var btLow: UIButton!
    @IBOutlet weak var lbPriority: UILabel!
    
    // MARK: - Variables
    var selectedPriority: String = "Normal Priority"
    var small: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Button design
        btHigh.layer.cornerRadius = 8.0
        btNormal.layer.cornerRadius = 8.0
        btLow.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func pressPriority(_ sender: UIButton) {
        if !small {
            lbPriority.text = sender.titleLabel?.text
        }
        else {
            lbPriority.text = (sender.titleLabel?.text)! + " Priority"
        }
        selectedPriority = lbPriority.text!
    }
    
    func setPriority(priority: String) {
        lbPriority.text = priority
    }
    
    func changeButtonText() {
        btHigh.setTitle("High", for: .normal)
        btNormal.setTitle("Normal", for: .normal)
        btLow.setTitle("Low", for: .normal)
        small = true
    }
}
