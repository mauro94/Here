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
    @objc dynamic var priority = ""
    @objc dynamic var date: Date? = nil
    @objc dynamic var completeDate: Date? = nil
    @objc dynamic var complete = false
    @objc dynamic var classCourse: Class?
    
    convenience init(title: String, note: String, priority: String, date: Date, classCourse: Class) {
        self.init()
        self.title = title
        self.note = note
        self.priority = priority
        self.date = date
        self.classCourse = classCourse
        self.completeDate = nil
        self.complete = false
    }
}
