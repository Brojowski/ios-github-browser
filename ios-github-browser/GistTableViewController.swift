//
//  GistTableViewController.swift
//  ios-github-browser
//
//  Created by Alex Gajowski on 4/9/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class GistTableViewController: UITableViewController {
    
    var loadSaveCounter = 0
    var GistsArray = [GistSerializable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GistsArray = (UIApplication.shared.delegate as? AppDelegate)?.getGists() ?? [GistSerializable]()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GistsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gistIdentifier", for: indexPath)

        cell.textLabel?.text = GistsArray[indexPath.row].name

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let filesVC = segue.destination as? FilesTableViewController
        filesVC?.gist = GistsArray[tableView.indexPathForSelectedRow!.row]
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
        
        // Debug output
        print(">>>Document Directory: \(documentDirectory!)")
        
        return fileWithPath! as NSURL
    }
    
    func save() {
        // Get the file to save the archive to
        //let archiveFile = MainTableViewController.archiveURL.path
        let archiveFile = getArchiveURL().path!
        
        //Debugging
        print(">>> save: \(loadSaveCounter) \(archiveFile)")
        
        // Do the archiving
        let success = NSKeyedArchiver.archiveRootObject(GistsArray,
                                                        toFile: archiveFile)
        
        if !success {
            print(">>> Archive failed.")
        }
        
        // Debugging
        loadSaveCounter += 1
    }
    
    func load() -> Bool {
        // Get the file to save the archive to
        //let archiveFile = MainTableViewController.archiveURL.path
        let archiveFile = getArchiveURL().path!
        
        // The file will not exist the first time the app is run
        guard FileManager().fileExists(atPath: archiveFile) else {
            print(">>> Does not exist: \(archiveFile)")
            return false
        }
        
        //Debugging
        print(">>> load: \(loadSaveCounter) \(archiveFile)")
        
        // Get the archived data
        let unArchivedData = NSKeyedUnarchiver.unarchiveObject(
            withFile: archiveFile)
        let unArchivedGists = unArchivedData as? [GistSerializable]
    
        guard unArchivedGists != nil else {
            return false
        }
        
        // Restore the Gists
        GistsArray = unArchivedGists!
        
        // Debugging
        loadSaveCounter += 1
        
        return true
    }

}
