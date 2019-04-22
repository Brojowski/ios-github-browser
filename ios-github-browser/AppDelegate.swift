//
//  AppDelegate.swift
//  ios-github-browser
//
//  Created by Alex Gajowski on 4/2/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let rootVC = application.windows.first?.rootViewController as! UINavigationController
        let tableVC = rootVC.viewControllers.first as! GistTableViewController
        save(gists: tableVC.gists)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func getArchiveURL () -> NSURL {
        // Get the default file manager
        let fileManager = FileManager()// NSFileManager.defaultManager()
        
        // Get an array of URLs
        let urls = fileManager.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        // Get the document directory
        let documentDirectory = urls.last
        let fileWithPath = documentDirectory?.appendingPathComponent("archive.data")
        
        return fileWithPath! as NSURL
    }
    
    func save(gists: [GistSerializable]) {
        // Get the file to save the archive to
        //let archiveFile = MainTableViewController.archiveURL.path
        let archiveFile = getArchiveURL().path!
        
        
        // Do the archiving
        let success = NSKeyedArchiver.archiveRootObject(gists, toFile: archiveFile)
        
        if !success {
            print(">>> Archive failed.")
        }
    }
    
    func load() -> [GistSerializable] {
        // Get the file to save the archive to
        //let archiveFile = MainTableViewController.archiveURL.path
        let archiveFile = getArchiveURL().path!
        
        // The file will not exist the first time the app is run
        guard FileManager().fileExists(atPath: archiveFile) else {
            print(">>> Does not exist: \(archiveFile)")
            return [GistSerializable]()
        }
        
        // Get the archived data
        let unArchivedData = NSKeyedUnarchiver.unarchiveObject(withFile: archiveFile)
        let unArchivedGists = unArchivedData as? [GistSerializable]
        
        guard unArchivedGists != nil else {
            return [GistSerializable]()
        }
        
        // Restore the Gists
        return unArchivedGists!
    }
}

