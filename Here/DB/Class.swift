//
//  Class.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/6/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import RealmSwift

class Class: Object {
    @objc dynamic var group = ""
    @objc dynamic var building = ""
    @objc dynamic var room = ""
    @objc dynamic var beaconUUID = ""
    @objc dynamic var beaconMinor = ""
    @objc dynamic var beaconMajor = ""
    @objc dynamic var hour = ""
    @objc dynamic var minute = ""
    @objc dynamic var duration = ""
    @objc dynamic var startDay = ""
    @objc dynamic var startMonth = ""
    @objc dynamic var startYear = ""
    @objc dynamic var endDay = ""
    @objc dynamic var endMonth = ""
    @objc dynamic var endYear = ""
    @objc dynamic var sunday = false
    @objc dynamic var monday = false
    @objc dynamic var tuesday = false
    @objc dynamic var wednesday = false
    @objc dynamic var thursday = false
    @objc dynamic var friday = false
    @objc dynamic var saturday = false
    @objc dynamic var course: Course?
    
    convenience init(group: String, building: String, room: String, beaconUUID: String, beaconMinor: String, beaconMajor: String, hour: String, minute: String, duration: String, startDay: String, startMonth: String, startYear: String, endDay: String, endMonth: String, endYear: String, sunday: Bool, monday: Bool, tuesday: Bool, wednesday: Bool, thursday: Bool, friday: Bool, saturday: Bool, course: Course) {
        self.init()
        self.group = group
        self.building = building
        self.room = room
        self.beaconUUID = beaconUUID
        self.beaconMinor = beaconMinor
        self.beaconMajor = beaconMajor
        self.hour = hour
        self.minute = minute
        self.duration = duration
        self.startDay = startDay
        self.startMonth = startMonth
        self.startYear = startYear
        self.endDay = endDay
        self.endMonth = minute
        self.endYear = endYear
        self.sunday = sunday
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.course = course
    }
}

