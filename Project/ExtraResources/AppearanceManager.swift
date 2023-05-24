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
    var backgroundColor: UIColor {
        return isDarkModeEnabled ? UIColor.black : UIColor.white
    }
    var searchBarColor: UIColor {
        return isDarkModeEnabled ? nearBlackColor : UIColor.systemGray6
    }
    var searchBarTextColor: UIColor {
        return isDarkModeEnabled ? UIColor.white : UIColor.black
    }

}
