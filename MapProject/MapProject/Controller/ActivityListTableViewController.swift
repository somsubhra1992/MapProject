//
//  ActivityListTableViewController.swift
//  MapProject
//
//  Created by Somsubhra Dasgupta on 09/04/21.
//  Copyright © 2021 Somsubhra. All rights reserved.
//

import UIKit

class ActivityListTableViewController: UITableViewController {

    var activityHierarchy : [[String:Any]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var activityList = CoreDatamanager.shared.fetchAllActivityList()
        processActivityData(activityList: activityList)
        
    }
    
    func processActivityData(activityList : [Activity])
    {
        self.activityHierarchy = [[String:Any]]()
        let uniquePlaces = Set(activityList.map({$0.event_place}))
        
        for place in uniquePlaces
        {
            let filteredList = activityList.filter({$0.event_place == place})
            let activityinfo = ["place":place,"activities":filteredList] as [String : Any]
            activityHierarchy.append(activityinfo)
        }
        
        self.tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.activityHierarchy.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        guard let activityInfo = self.activityHierarchy[section] as? [String:Any],
            let activities = activityInfo["activities"] as? [Activity] else
        {
            return 0
        }
        
        return activities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellView", for: indexPath)
        
        if let activityCell = cell as? ActivityListTableCellView
        {
            if let activityInfo = self.activityHierarchy[indexPath.section] as? [String:Any],
                let activities = activityInfo["activities"] as? [Activity],
                let activity = activities[indexPath.row] as? Activity,
                let eventType = activity.event_type,
                let eventTime = activity.event_time
            {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateStr = dateFormatter.string(from: eventTime)
                
                activityCell.event_type.text = eventType
                activityCell.event_time.text = dateStr
                
            }
            
            return activityCell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let activityInfo = self.activityHierarchy[section] as? [String:Any],
            let activity_name = activityInfo["place"] as? String else
        {
            return ""
        }
        
        return activity_name
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class ActivityListTableCellView : UITableViewCell
{
    @IBOutlet weak var event_type: UILabel!
    @IBOutlet weak var event_time: UILabel!
}
