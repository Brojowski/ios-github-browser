//
//  CodeViewController.swift
//  ios-github-browser
//
//  Created by Alex Gajowski on 4/9/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit
import Highlightr
import ActionSheetPicker_3_0

class CodeViewController: UIViewController {
    @IBOutlet weak var codeView: UILabel!
    @IBOutlet weak var toolBar: UIToolbar!
    
    let syntax = Highlightr()!
    var theme: String = ("Androidstudio")
    
    // Gets what theme the user picked
    enum pickerSource : Int {
        case theme = 0
        case language
    }
    
    var file = File()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolBar.alpha = 0.0
        
        // creating the nav bar button
        let themeButton = UIBarButtonItem(title: "Themes", style: UIBarButtonItem.Style.plain, target: self, action: #selector(themeButtonTapped))
    
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationItem.title = file.filename
        self.navigationItem.rightBarButtonItem = themeButton
    
        let defaultTheme = UserDefaults.standard.value(forKey: "theme") as? String
    
        syntax.setTheme(to: defaultTheme ?? "androidstudio")
        codeView.backgroundColor = syntax.theme.themeBackgroundColor
        view.backgroundColor = syntax.theme.themeBackgroundColor
        
        let code = try! String(contentsOf: file.rawURL!)
        
        codeView.attributedText = syntax.highlight(code)
    }
    
    // Brings up the ActionSheetPicker with list of all themes
    @objc func themeButtonTapped() {
        let themes = syntax.availableThemes()
        let indexOrNil = themes.index(of: theme.lowercased())
        let index = (indexOrNil == nil) ? 0 : indexOrNil!
        
        ActionSheetStringPicker.show(withTitle: "Pick a Theme",
                                     rows: themes,
                                     initialSelection: index,
                                     doneBlock:
            { picker, index, value in
                let theme = value! as! String
                self.syntax.setTheme(to: theme)
                UserDefaults.standard.setValue(theme, forKey: "theme")
                self.theme = theme.capitalized
                self.updateColors()
        },
                                     cancel: nil,
                                     origin: toolBar)
        
    }
    
    //updates the background and text color after picking a new theme
    func updateColors()
    {
        let code = try! String(contentsOf: file.rawURL!)
        codeView.backgroundColor = syntax.theme.themeBackgroundColor
        toolBar.barTintColor = syntax.theme.themeBackgroundColor
        toolBar.tintColor = invertColor(toolBar.barTintColor!)
        codeView.attributedText = syntax.highlight(code)
    }
    
    // ensures the background and text are different colors
    func invertColor(_ color: UIColor) -> UIColor
    {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: nil)
        return UIColor(red:1.0-r, green: 1.0-g, blue: 1.0-b, alpha: 1)
    }

    
}
