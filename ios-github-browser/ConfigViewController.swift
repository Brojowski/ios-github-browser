//
//  ConfigViewController.swift
//  ios-github-browser
//
//  Created by Alex Gajowski on 4/4/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {
    @IBOutlet weak var ownerField: UITextField!
    @IBOutlet weak var gistIdField: UITextField!
    
    static let gistLinkRegex: String = "gist.github.com\\/([^\\/]+)\\/(.+)$"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onLinkChanged(_ sender: UITextField) {
        let link = sender.text ?? ""
        
        let regex = try? NSRegularExpression(pattern: ConfigViewController.gistLinkRegex, options: .caseInsensitive)
        let match = regex?.firstMatch(in: link, options: [], range: NSRange(location: 0, length: link.count))

        let owner = link[Range((match?.range(at: 1))!, in: link)!]
        let gistId = link[Range((match?.range(at: 2))!, in: link)!]

        ownerField.text = String(owner)
        gistIdField.text = String(gistId)
    }
}
