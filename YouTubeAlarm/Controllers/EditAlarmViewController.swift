//
//  EditAlarmViewController.swift
//  YouTubeAlarm
//
//  Created by Stefanie Seah on 17/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import UIKit
import RealmSwift

class EditAlarmViewController: UIViewController {
    
    var alarm: Alarm?

    @IBOutlet weak var alarmTimePicker: UIDatePicker!
    
    @NSCopying var calendar: NSCalendar!
    
    @IBOutlet weak var alarmDescriptionTextField: UITextField!
    
    @IBOutlet weak var alarmDescriptionTextView: UITextView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let alarm = alarm {
            alarmDescriptionTextField.text = alarm.alarmDescription
            alarmDescriptionTextView.text = ""
        } else {
            alarmDescriptionTextField.text = ""
            alarmDescriptionTextView.text = ""
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listAlarmsViewController = segue.destinationViewController as! ListAlarmsViewController
        if segue.identifier == "Save" {
            if let alarm = alarm {
                let newAlarm = Alarm()
                newAlarm.alarmDescription = alarmDescriptionTextField.text ?? ""
                RealmHelper.updateAlarm(alarm, newAlarm: newAlarm)
            } else {
                let alarm = Alarm()
                alarm.alarmDescription = alarmDescriptionTextField.text ?? ""
                RealmHelper.addAlarm(alarm)
            }
            listAlarmsViewController.alarms = RealmHelper.retrieveAlarms()
        }
    }
}

