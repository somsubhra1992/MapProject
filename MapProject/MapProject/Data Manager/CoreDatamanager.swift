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
    
//    func updateUserProfileDetails(using name:String)
//    {
//        if let cntxt = self.context
//        {
//            let fetchRequest : NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
//
//            do{
//                let userProfiles = try cntxt.fetch(fetchRequest)
//                let userProfile = userProfiles[0]
//                userProfile.name = name
//                try cntxt.save()
//            }
//            catch
//            {
//                print("Error while loading \(error)")
//            }
//
//        }
//    }
    
//    func loadUserDetailsInfo() -> Activity?
//    {
//        if let cntxt = self.context
//        {
//            let fetchRequest : NSFetchRequest<Activity> = UserProfile.fetchRequest()
//
//            do{
//                let userDetails = try cntxt.fetch(fetchRequest)
//                return userDetails.last
//            }
//            catch
//            {
//                print("Error while loading \(error)")
//            }
//
//        }
//
//        return nil
//    }
    
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
    
//    func addRecordsForLikedProfiles(using profile : FriendProfilesModel)
//    {
//        fetchAllFriendList()
//
//        if let cntxt = self.context
//        {
//            if !presentIds.contains(profile.id)
//            {
//                let frndProfile = FriendProfiles(context: cntxt)
//                frndProfile.name = profile.name
//                frndProfile.gender = profile.gender
//                frndProfile.age = Int16(Int64(profile.age))
//                frndProfile.favoriteColor = profile.favoriteColor
//                frndProfile.phone = profile.phone
//                frndProfile.lastSeen = profile.lastSeen
//                frndProfile.email = profile.email
//                frndProfile.id = profile.id
//                frndProfile.picture = profile.picture
//                frndProfile.liked = profile.liked
//
//                do{
//                    try cntxt.save()
//                }
//                catch
//                {
//                    print("Error while saving \(error)")
//                }
//            }
//
//        }
//    }
    
//    func updateFriendProfileData(using profile : FriendProfiles)
//    {
//        if let cntxt = self.context
//        {
//            let fetchRequest : NSFetchRequest<FriendProfiles> = FriendProfiles.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "id = %@", profile.id!)
//
//            do{
//                let friendProfiles = try cntxt.fetch(fetchRequest)
//                let frndProfile = friendProfiles[0]
//                frndProfile.liked = profile.liked
//                try cntxt.save()
//            }
//            catch
//            {
//                print("Error while loading \(error)")
//            }
//
//        }
//    }
//
//    func fetchRecordsForMaleProfiles() -> [FriendProfiles]?
//    {
//        if let cntxt = self.context
//        {
//            let fetchRequest : NSFetchRequest<FriendProfiles> = FriendProfiles.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "gender = %@", "male")
//
//            do{
//                let friendProfiles = try cntxt.fetch(fetchRequest)
//                print(friendProfiles.map({$0.liked}))
//                return friendProfiles
//            }
//            catch
//            {
//                print("Error while loading \(error)")
//            }
//
//        }
//
//        return nil
//    }
//
//    func fetchRecordsForFemaleProfiles() -> [FriendProfiles]?
//    {
//        if let cntxt = self.context
//        {
//            let fetchRequest : NSFetchRequest<FriendProfiles> = FriendProfiles.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "gender = %@", "female")
//
//            do{
//                let friendProfiles = try cntxt.fetch(fetchRequest)
//                print(friendProfiles.map({$0.liked}))
//                return friendProfiles
//            }
//            catch
//            {
//                print("Error while loading \(error)")
//            }
//
//        }
//
//        return nil
//    }
//
//    func fetchRecordsForLikedProfiles() -> [FriendProfiles]?
//    {
//        if let cntxt = self.context
//        {
//            let fetchRequest : NSFetchRequest<FriendProfiles> = FriendProfiles.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "liked = %@","Yes")
//
//            do{
//                let friendProfiles = try cntxt.fetch(fetchRequest)
//                return friendProfiles
//            }
//            catch
//            {
//                print("Error while loading \(error)")
//            }
//
//        }
//
//        return nil
//    }
    
    
}
