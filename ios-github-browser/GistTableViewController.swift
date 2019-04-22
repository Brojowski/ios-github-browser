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
    var gists = [GistSerializable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Gists"

        
        gists = (UIApplication.shared.delegate as? AppDelegate)?.load() ?? [GistSerializable]()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gistIdentifier", for: indexPath)

        cell.textLabel?.text = gists[indexPath.row].name

        return cell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            self.gists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    
        return [delete]
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let filesVC = segue.destination as? FilesTableViewController
        filesVC?.gist = gists[tableView.indexPathForSelectedRow!.row]
    }
    
    func addGist(gist: GistSerializable) {
        gists.append(gist)
        tableView.reloadData()
    }
}
