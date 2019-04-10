//
//  CodeViewController.swift
//  ios-github-browser
//
//  Created by Alex Gajowski on 4/9/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit
import Highlightr

class CodeViewController: UIViewController {
    @IBOutlet weak var codeView: UILabel!
    
    var file = File()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationItem.title = file.filename
    
        
        let syntax = Highlightr()!
        syntax.setTheme(to: "Androidstudio")
        codeView.backgroundColor = syntax.theme.themeBackgroundColor
        view.backgroundColor = syntax.theme.themeBackgroundColor
        
        let code = try! String(contentsOf: file.rawURL!)
        
        codeView.attributedText = syntax.highlight(code)
    }

}
