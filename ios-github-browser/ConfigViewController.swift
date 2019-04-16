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
    @IBOutlet weak var gistNameField: UITextField!
    
    static let gistLinkRegex: String = "gist.github.com\\/([^\\/]+)\\/(.+)$"
    
    
    var gistArray = [GistSerializable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLinkChanged(_ sender: UITextField) {
        let link = sender.text ?? ""
        
        let regex = try? NSRegularExpression(pattern: ConfigViewController.gistLinkRegex, options: .caseInsensitive)
        let match = regex?.firstMatch(in: link, options: [], range: NSRange(location: 0, length: link.count))
        
        if match == nil {
            return
        }
        
        let owner = link[Range((match?.range(at: 1))!, in: link)!]
        let gistId = link[Range((match?.range(at: 2))!, in: link)!]

        ownerField.text = String(owner)
        gistIdField.text = String(gistId)
    }
    
    func archiveGists(gists: [GistSerializable]) {
        let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: gists, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedData, forKey: "encodedGists")
        UserDefaults.standard.synchronize()
        
        print("succesfully archived the array(I think lol)")
        print("Printing encoded gists", UserDefaults.standard.object(forKey: "encodedGists") as Any)
    }
    
    @IBAction func onAddGist(_ sender: UIButton) {
        let owner = ownerField.text
        let gistId = gistIdField.text
        let name = gistNameField.text
        
        
        
        print("New entry: \(owner) the id: \(gistId) the name: \(name)")
        
        gistArray.append(GistSerializable(owner: owner ?? " ", id: gistId ?? " ", name: name ?? " "))
        archiveGists(gists: gistArray)
//        if owner.isNilOrEmpty() {
//            print("\(owner)")
//        }
//
//        if gistId.isNilOrEmpty() {
//            print("\(gistId)")
//        }
//
//        if name.isNilOrEmpty() {
//            print("\(name)")
//        }
//        print(owner!, gistId!, name!)
//        let gist = GistSerializable(owner: owner!, id: gistId!, name: name!)
//        print("gist is:", gist)
//        (UIApplication.shared.delegate as? AppDelegate)?.saveGist(gist: gist)
    }
    
    
    @IBAction func printGists(_ sender: UIButton) {
        let decoded = UserDefaults.standard.data(forKey: "encodedGists")
        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [GistSerializable]
        print(decodedTeams)
        
    }
    
}

extension String {
    func isNilOrEmpty() -> Bool {
        return self.isEmpty
    }
}

extension Optional where Wrapped == String {
    func isNilOrEmpty() -> Bool {
        return self?.isEmpty ?? true
    }
}
