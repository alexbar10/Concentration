//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Alejandro Barranco on 13/08/19.
//  Copyright © 2019 Alejandro Barranco. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    let themes = [
        "Sports" : Theme(backgroundView: #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1), backgroundButton: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), emojis: "⚽️🏀🏈⚾️🎾🎱⛳️⛸"),
        "Animals" : Theme(backgroundView: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), backgroundButton: #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1), emojis: "🐶🐱🦁🐭🐔🐧🐣🦄"),
        "Faces" : Theme(backgroundView: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), backgroundButton: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), emojis: "😀😆😎🤩😡😱😭😏")
    ]
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                    if let cvc = segue.destination as? ConcentrationViewController {
                        cvc.themePassed = theme
                    }
                }
        }
    }
}
