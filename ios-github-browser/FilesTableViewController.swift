//
//  FilesTableViewController.swift
//  ios-github-browser
//
//  Created by Alex Gajowski on 4/9/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class FilesTableViewController: UITableViewController {

    private var _files = [File]()
    
    weak var gist: GistSerializable!
    
    override func viewDidLoad() {
        self.navigationItem.title = gist.name
        
        Octokit().gist(id: gist.id) {res in
            switch (res) {
            case .success(let gist):
                self._files = Array(gist.files.values)
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            case .failure(let err):
                print(err)
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return _files.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fileIdentifier", for: indexPath)


        cell.textLabel?.text = _files[indexPath.row].filename

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let codeVC = segue.destination as! CodeViewController
        codeVC.file = _files[tableView.indexPathForSelectedRow!.row]
    }

}
