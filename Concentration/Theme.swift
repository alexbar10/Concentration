//
//  Theme.swift
//  Concentration
//
//  Created by Alejandro Barranco on 8/2/19.
//  Copyright © 2019 Alejandro Barranco. All rights reserved.
//

import UIKit

struct Theme {
    var backgroundView: UIColor
    var backgroundButton: UIColor
    var emojis: String
    
    
    init() {
        backgroundView = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundButton = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emojis = String()
    }
    
    init(backgroundView: UIColor, backgroundButton: UIColor, emojis: String) {
        self.backgroundView = backgroundView
        self.backgroundButton = backgroundButton
        self.emojis = emojis
    }
}
