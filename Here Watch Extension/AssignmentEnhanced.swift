//
//  AssignmentEnhanced.swift
//  Here Watch Extension
//
//  Created by Mauro Amarante Esparza on 4/5/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import RealmSwift

class AssignmentEnhanced: Object {
    @objc dynamic var title = ""
    @objc dynamic var note = ""
    @objc dynamic var priority = ""
    @objc dynamic var date = ""
    @objc dynamic var courseName = ""
    @objc dynamic var courseColorRed: Float = 0.0
    @objc dynamic var courseColorGreen: Float = 0.0
    @objc dynamic var courseColorBlue: Float = 0.0
    @objc dynamic var courseColorAlpha: Float = 0.0
    
    convenience init(title: String, note: String, priority: String, date: String, courseName: String, courseColorRed: Float, courseColorGreen: Float, courseColorBlue: Float, courseColorAlpha: Float) {
        self.init()
        self.title = title
        self.note = note
        self.priority = priority
        self.date = date
        self.courseName = courseName
        self.courseColorRed = courseColorRed
        self.courseColorGreen = courseColorGreen
        self.courseColorBlue = courseColorBlue
        self.courseColorAlpha = courseColorAlpha
    }
}
