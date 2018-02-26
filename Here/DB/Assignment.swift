//
//  Assignment.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import RealmSwift

class Assignment: Object {
    @objc dynamic var title = ""
    @objc dynamic var note = ""
    @objc dynamic var priority = 0
    @objc dynamic var date: Date? = nil
    @objc dynamic var course: Course?
    
    convenience init(title: String, note: String, priority: Int, date: Date, course: Course) {
        self.init()
        self.title = title
        self.note = note
        self.priority = priority
        self.date = date
        self.course = course
    }
}
