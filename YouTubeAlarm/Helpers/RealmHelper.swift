//
//  RealmHelper.swift
//  YouTubeAlarm
//
//  Created by Stefanie Seah on 18/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import RealmSwift
import Realm
import UIKit

class RealmHelper {
    static func addAlarm(alarm: Alarm){
        let realm = try! Realm()
        try! realm.write(){
            realm.add(alarm)
        }
    }
    
    static func deleteAlarm(alarm: Alarm) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(alarm)
        }
    }
    
    static func updateAlarm(alarmToBeUpdated: Alarm, newAlarm: Alarm) {
        let realm = try! Realm()
        try! realm.write() {
            alarmToBeUpdated.alarmDescription = newAlarm.alarmDescription

        }
    }
    
    static func changeAlarmState(alarmToBeUpdated: Alarm, newAlarmState: Bool) {
        let realm = try! Realm()
        try! realm.write() {
        alarmToBeUpdated.alarmOn = newAlarmState
            
        }
    }
    
    static func retrieveAlarms() -> Results<Alarm> {
        let realm = try! Realm()
        return realm.objects(Alarm)
    }
}




