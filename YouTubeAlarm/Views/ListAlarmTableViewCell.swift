//
//  ListAlarmTableViewCell.swift
//  YouTubeAlarm
//
//  Created by Stefanie Seah on 17/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import UIKit

class ListAlarmTableViewCell: UITableViewCell {

    @IBOutlet weak var alarmTimeLabel: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var alarm: Alarm?
    
    @IBAction func alarmSwitchHandler(sender: UISwitch) {
        
        if let alarm = alarm {
            if sender.on {
                RealmHelper.changeAlarmState(alarm, newAlarmState: true)
                print(alarm.alarmOn)
            } else {
                RealmHelper.changeAlarmState(alarm, newAlarmState: false)
                print(alarm.alarmOn)
            }
        }
        
    }
    
}
