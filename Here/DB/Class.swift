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
    @objc dynamic var red: Float = 0.0
    @objc dynamic var blue: Float = 0.0
    @objc dynamic var green: Float = 0.0
    @objc dynamic var alpha: Float = 0.0
    @objc dynamic var course: Course?
    
    convenience init(group: String, building: String, room: String, beaconUUID: String, beaconMinor: String, beaconMajor: String, hour: String, minute: String, duration: String, startDay: String, startMonth: String, startYear: String, endDay: String, endMonth: String, endYear: String, sunday: Bool, monday: Bool, tuesday: Bool, wednesday: Bool, thursday: Bool, friday: Bool, saturday: Bool, red: Float, green: Float, blue: Float, alpha: Float, course: Course) {
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
        self.endMonth = endMonth
        self.endYear = endYear
        self.sunday = sunday
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
        self.course = course
    }
    
    convenience init(group: String, building: String, room: String, red: Float, green: Float, blue: Float, alpha: Float, course: Course) {
        self.init()
        self.group = group
        self.building = building
        self.room = room
        self.beaconUUID = ""
        self.beaconMinor = ""
        self.beaconMajor = ""
        self.hour = ""
        self.minute = ""
        self.duration = ""
        self.startDay = ""
        self.startMonth = ""
        self.startYear = ""
        self.endDay = ""
        self.endMonth = ""
        self.endYear = ""
        self.sunday = false
        self.monday = false
        self.tuesday = false
        self.wednesday = false
        self.thursday = false
        self.friday = false
        self.saturday = false
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
        self.course = course
    }
}

