//
//  TableViewCellClassAssignment.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/28/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewCellClassAssignment: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var lbClassName: UILabel!
    @IBOutlet weak var vClasscolor: UIView!
    @IBOutlet weak var pvClass: UIPickerView!
    
    // MARK: - Variables
    let realm = try! Realm()
    var classes: Results<Class>!
    var classesArray = [Class]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Get class data
        self.pvClass.dataSource = self
        self.pvClass.delegate = self
        classes = realm.objects(Class.self)
        classesArray = Array(classes)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Circle color
        let circle = UIBezierPath(arcCenter: CGPoint(x: 15,y: 15), radius: CGFloat(8), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circle.cgPath
        
        let red = CGFloat(classes[row].red)
        let green = CGFloat(classes[row].green)
        let blue = CGFloat(classes[row].blue)
        let alpha = CGFloat(classes[row].alpha)
        
        shapeLayer.fillColor = UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
        
        vClasscolor.layer.addSublayer(shapeLayer)
        lbClassName.text = classesArray[row].course?.name
        
        return classesArray[row].course?.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lbClassName.text = classesArray[row].course?.name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classesArray.count
    }
    
    func setClass(classIndex: Int) {
        pvClass.selectRow(classIndex, inComponent: 0, animated: true)
    }
}
