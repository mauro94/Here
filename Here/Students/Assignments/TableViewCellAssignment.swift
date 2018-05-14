//
//  TableViewCellAssignment.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/6/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewCellAssignment: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var btComplete: CheckBox!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbCourse: UILabel!
    @IBOutlet weak var vColor: UIView!
    
    // MARK: - Variables
    var assignment: Assignment!
    let realm = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func completeAssignment(_ sender: UIButton) {
        let date = Date()
        
        // Save in realm
        try! realm.write {
            assignment.complete = !assignment.complete
            assignment.completeDate = date
        }
        
        // Watch
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let watchConnectionHelper = appDelegate.watchConnectionHelper
        watchConnectionHelper.sendData(message: assignment.title, assignment: assignment)
    }
}
