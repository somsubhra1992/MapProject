//
//  CoreDatamanager.swift
//  MapProject
//
//  Created by Somsubhra Dasgupta on 09/04/21.
//  Copyright © 2021 Somsubhra. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class CoreDatamanager : NSObject
{
    public static let shared = CoreDatamanager()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var presentIds = [String]()
    
    private override init()
    {
        super.init()
    }
    
    func addActivityDetails(using event_place:String, event_time: Date, event_type:String)
    {
        if let cntxt = self.context
        {
            let activity = Activity(context: cntxt)
            activity.event_place = event_place
            activity.event_time = event_time
            activity.event_type = event_type

            do{
                try cntxt.save()
            }
            catch
            {
                print("Error while saving \(error)")
            }

        }
    }

    
    func fetchAllActivityList() -> [Activity]
    {
        var activityList = [Activity]()
        
        if let cntxt = self.context
        {
            let fetchRequest : NSFetchRequest<Activity> = Activity.fetchRequest()

            do{
                activityList = try cntxt.fetch(fetchRequest)
                return activityList
            }
            catch
            {
                print("Error while loading \(error)")
            }
            
        }
        
        return activityList
    }
    

    
    
}
