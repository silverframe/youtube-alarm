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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if alarm != nil {
            self.title = "Edit Alarm"
        } else {
            self.title = "New Alarm"
         }
        
        setUpDefault()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listAlarmsViewController = segue.destinationViewController as! ListAlarmsViewController
        if segue.identifier == "Save" {
            if let alarm = alarm {
                let newAlarm = Alarm()
                newAlarm.alarmDescription = getAlarmTime()
                newAlarm.alarmTime = alarmTimePicker.date
                newAlarm.alarmOn = false
                RealmHelper.updateAlarm(alarm, newAlarm: newAlarm)
            } else {
                let alarm = Alarm()
                alarm.alarmDescription = getAlarmTime()
                alarm.alarmTime = alarmTimePicker.date
                alarm.alarmOn = false
                RealmHelper.addAlarm(alarm)
            }
            listAlarmsViewController.alarms = RealmHelper.retrieveAlarms()
        }
    }
    
    func getAlarmTime() -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        return dateFormatter.stringFromDate(alarmTimePicker.date)
        
    }
}

extension EditAlarmViewController {
    
    func setUpDefault(){
        if let alarm = alarm {
            if let time = alarm.alarmTime {
                alarmTimePicker.date = time
            } else {
                alarmTimePicker.date = NSDate()
            }
        }
    }
}

