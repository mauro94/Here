//
//  Assignment.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import RealmSwift

class Assingment: Object {
    @objc dynamic var title = ""
    @objc dynamic var note = ""
    @objc dynamic var priority = 0
    @objc dynamic var value: Date? = nil
    @objc dynamic var course: Course?
}
