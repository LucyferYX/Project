//
//  AppearanceManager.swift
//  Project
//
//  Created by liene.krista.neimane on 24/05/2023.
//

import UIKit

class AppearanceManager {
    static let shared = AppearanceManager()

    let nearBlackColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
    var isDarkModeEnabled = false
    var selectedColorIndex = 0
    //let backgroundColor = getBackgroundColor()
    
    var backgroundColor: UIColor {
        return getBackgroundColor()
    }
    var searchBarColor: UIColor {
        return isDarkModeEnabled ? nearBlackColor : UIColor.systemGray6
    }
    var searchBarTextColor: UIColor {
        return isDarkModeEnabled ? UIColor.white : UIColor.black
    }
    
    // For user selecting colour
    func getBackgroundColor() -> UIColor {
        switch selectedColorIndex {
        case 0: // System (black or white depending on mode)
            return isDarkModeEnabled ? UIColor.black : UIColor.white
        case 1: // Green
            return UIColor(red: 89/255, green: 79/255, blue: 59/255, alpha: 1)
        case 2: // Brown
            return UIColor(red: 119/255, green: 98/255, blue: 88/255, alpha: 1)
        case 3: // Purple
            return UIColor(red: 137/255, green: 98/255, blue: 121/255, alpha: 1)
        default:
            return isDarkModeEnabled ? UIColor.black : UIColor.white
        }
    }
}
