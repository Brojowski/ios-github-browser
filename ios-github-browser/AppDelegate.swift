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
        
        outputGists()
        
        let rootViewController = application.windows.first?.rootViewController
            as! UINavigationController
        let GistTableViewController = rootViewController.viewControllers.first
            as! GistTableViewController
        
        // Will fail when the app starts for the first time.
        _ = GistTableViewController.load()
        
        
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
        tableVC.save()
        
        let rootViewController = application.windows.first?.rootViewController
            as! UINavigationController
        let GistTableViewController = rootViewController.viewControllers.first
            as! GistTableViewController
        GistTableViewController.save()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        let rootViewController = application.windows.first?.rootViewController
            as! UINavigationController
        let GistTableViewController = rootViewController.viewControllers.first
            as! GistTableViewController
        let success = GistTableViewController.load()
        if  !success {
            print(">>>>>>>>Saved data load failed.")
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func getGists() -> [GistSerializable] {
        let pl = Bundle.main.path(forResource: "gist_list", ofType: ".plist")
        
        let dict = NSDictionary(contentsOfFile: pl!) as? [NSString: AnyObject]
        
        let rawGists = dict!["gists"] as! [[String: String]]
        let gists = rawGists.map { rg in
            return GistSerializable(dict: rg)
        }
        
        return gists
    }
    
    private func saveGists(gists : GistSerializable) {
        let pl = Bundle.main.path(forResource: "gist_list", ofType: ".plist")
        
        /*let gDicts = gists.map { g in
            return g.serialize() as NSDictionary
        }
        
        var dict = NSMutableDictionary()
        dict.setValue("gists", gDicts as NSArray)
        */
 
        let nsd : NSDictionary = gists.serialize() as NSDictionary
        nsd.write(toFile: pl!, atomically: true)
    }
    
    func saveGist(gist: GistSerializable) {
        var gists = getGists()
        gists.append(gist)
        saveGists(gists: gist)
    }
    
    func outputGists() {
        let gists = getGists()
        for g in gists {
            print("{ \n\to: \(g.owner) \n\tid: \(g.id) \n\tn: \(g.name) \n}")
        }
    }
}

