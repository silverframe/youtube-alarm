//
//  ListAlarmsViewController.swift
//  YouTubeAlarm
//
//  Created by Stefanie Seah on 17/7/16.
//  Copyright © 2016 Stefanie Seah. All rights reserved.
//

import UIKit
import RealmSwift

class ListAlarmsViewController: UITableViewController {
    var alarms: Results<Alarm>!{
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarms = RealmHelper.retrieveAlarms()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("listAlarmTableViewCell", forIndexPath: indexPath) as! ListAlarmTableViewCell
        
        let row = indexPath.row
        
        let alarm = alarms[row]

        cell.alarmTimeLabel.text = alarm.alarmDescription
        
        cell.alarm = alarm
        
        return cell 
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            RealmHelper.deleteAlarm(alarms[indexPath.row])
            alarms = RealmHelper.retrieveAlarms()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "editAlarm" {
                print("table cell tapped")
                
                let indexPath = tableView.indexPathForSelectedRow!
                let alarm = alarms[indexPath.row]
                let editAlarmViewController = segue.destinationViewController as! EditAlarmViewController
                editAlarmViewController.alarm = alarm
                
            } else if identifier == "addAlarm" {
                print("+ button tapped")
            }
        }
    }
    
    @IBAction func unwindToListAlarmsViewController(segue: UIStoryboardSegue){
        
    }
}