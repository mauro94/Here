//
//  Course.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import RealmSwift

class Course: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var department = ""
    
    convenience init(id: String, name: String, department: String) {
        self.init()
        self.id = id
        self.name = name
        self.department = department
    }
    
    convenience init(name: String) {
        self.init()
        self.id = ""
        self.name = name
        self.department = "No department"
    }
}
