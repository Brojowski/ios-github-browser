//
//  ViewController.swift
//  ios-github-browser
//
//  Created by Alex Gajowski on 4/2/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Octokit().gists(owner: "staltz", completion: { res in
            switch res {
            case .success(let gists):
                for g in gists {
                    print(g.files)
                }
            case .failure(let err):
                print(err)
            }
        })
        
    }


}

