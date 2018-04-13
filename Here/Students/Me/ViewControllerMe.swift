//
//  ViewControllerMe.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/7/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerMe: UIViewController,UITableViewDelegate, UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var lbStudentid: UILabel!
    @IBOutlet weak var tbOptions: UITableView!
    
    // MARK: - Variables
    let realm = try! Realm()
    var student: Results<Student>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get data
        student = realm.objects(Student.self)

        // Set data
        self.title = student[0].name
        lbStudentid.text = student[0].id
        
        // Tableview
        tbOptions.delegate = self
        tbOptions.dataSource = self
        tbOptions.tableFooterView = UIView()
        
        // Remove navbar shadow
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "assignmentCell", for: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "phoneCell", for: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "other", for: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
    }
}
