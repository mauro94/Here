//
//  TableViewCellCourseAssignment.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/28/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewCellCourseAssignment: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var lbCourseName: UILabel!
    @IBOutlet weak var pvCourses: UIPickerView!
    @IBOutlet weak var vCoursecolor: UIView!
    
    // MARK: - Variables
    let realm = try! Realm()
    var courses: Results<Course>!
    var coursesArray = [Course]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Get course data
        self.pvCourses.dataSource = self
        self.pvCourses.delegate = self
        courses = realm.objects(Course.self)
        coursesArray = Array(courses)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        // Circle color
        let circle = UIBezierPath(arcCenter: CGPoint(x: 15,y: 15), radius: CGFloat(8), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circle.cgPath
        
        let red = CGFloat(courses[row].red)
        let green = CGFloat(courses[row].green)
        let blue = CGFloat(courses[row].blue)
        let alpha = CGFloat(courses[row].alpha)
        
        shapeLayer.fillColor = UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
        
        vCoursecolor.layer.addSublayer(shapeLayer)
        lbCourseName.text = coursesArray[row].name
        
        return coursesArray[row].name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coursesArray.count
    }

}
