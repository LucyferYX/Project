//
//  MainViewController.swift
//  Project
//
//  Created by liene.krista.neimane on 19/05/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var ThemeSwitch: UISwitch!
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var InfoButton: UIButton!
    @IBOutlet weak var TitleLabel: UILabel!
    
    var darkIsOn: Bool = false
    let appearance = UINavigationBarAppearance()
    
    // Custom colours
    let customGreen = UIColor(red: 36/255, green: 79/255, blue: 37/255, alpha: 1)
    let customPink = UIColor(red: 0.85, green: 0.61, blue: 0.86, alpha: 1)
    let customYellow = UIColor(red: 0.94, green: 0.92, blue: 0.75, alpha: 1)
    let customBlue = UIColor(red: 0.41, green: 0.35, blue: 0.59, alpha: 1)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkThemeIsOn(isOn: ThemeSwitch.isOn)
        
        // appearance.configureWithDefaultBackground()
        // Do any additional setup after loading the view.
    }
    
    
    // Info button will display information about this project
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    @IBAction func InfoButtonTap(_ sender: UIButton) {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            basicActionAlert(title: "App information", message: "Creator: Liene Krista Neimane\nDate: 22.05.23.\nCourse: iOS Bootcamp\nv\(appVersion)")
        } else {
            basicActionAlert(title: "App information", message: "Creator: Me\nDate: 22.05.23.\nCourse: B\nVersion information not available")
        }
    }

    
    // For viewing setttings
    @IBAction func SettingsButtonTap(_ sender: UIButton) {
    }
    
    
    // Background image with rounded bottom corners
    @IBOutlet weak var BG: UIImageView!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let maskPath = UIBezierPath(roundedRect: BG.bounds,byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 70, height: 30))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        BG.layer.mask = shape
    }
    
    
    // Light and dark theme slider
    @IBAction func ThemeSlider(_ sender: UISwitch) {
        darkThemeIsOn(isOn: sender.isOn)
    }
    
    func darkThemeIsOn(isOn: Bool){
        if isOn {
            // Dark theme
            BG.backgroundColor = UIColor.black
            SettingsButton.tintColor = customGreen
            InfoButton.tintColor = customGreen
            TitleLabel.textColor = customYellow
            UINavigationBar.appearance().tintColor = customGreen
            overrideUserInterfaceStyle = .dark
            appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: customGreen]
            navigationController?.navigationBar.standardAppearance = appearance
        } else {
            // Light theme
            BG.backgroundColor = UIColor.white
            SettingsButton.tintColor = customPink
            InfoButton.tintColor = customPink
            TitleLabel.textColor = customBlue
            UINavigationBar.appearance().tintColor = customPink
            overrideUserInterfaceStyle = .light
            appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: customPink]
            navigationController?.navigationBar.standardAppearance = appearance
        }
    }
    
    
    // Info button alert
    func basicActionAlert(title: String?, message: String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    
    // Showcasing images in main screen
    
    
}
