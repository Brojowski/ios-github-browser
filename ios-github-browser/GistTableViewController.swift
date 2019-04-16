//
//  GistTableViewController.swift
//  ios-github-browser
//
//  Created by Alex Gajowski on 4/9/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class GistTableViewController: UITableViewController {
    

    private var gists = [GistSerializable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gists = (UIApplication.shared.delegate as? AppDelegate)?.getGists() ?? [GistSerializable]()
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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let filesVC = segue.destination as? FilesTableViewController
        filesVC?.gistId = gists[tableView.indexPathForSelectedRow!.row].id
    }

}
