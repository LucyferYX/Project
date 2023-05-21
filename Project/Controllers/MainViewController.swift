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
    
    var darkIsOn: Bool = false
    
    // Custom colours
    let customGreen = UIColor(red: 36/255, green: 79/255, blue: 37/255, alpha: 1)
    let customPink = UIColor(red: 0.85, green: 0.61, blue: 0.86, alpha: 1)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkThemeIsOn(isOn: ThemeSwitch.isOn)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func InfoButtonTap(_ sender: UIButton) {
        basicActionAlert(title: "App information", message: "Creator: Liene Krista Neimane")
    }
    
    @IBAction func SettingsButtonTap(_ sender: UIButton) {
    }
    
    
    // Background image with rounded bottom corners
    @IBOutlet weak var BG: UIImageView!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let maskPath = UIBezierPath(roundedRect: BG.bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
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
//            InfoButton.setTitleColor(UIColor.white, for: .normal)
//            SettingsButton.setTitleColor(UIColor.white, for: .normal)
            SettingsButton.tintColor = customGreen
            InfoButton.tintColor = customGreen
            overrideUserInterfaceStyle = .dark
        } else {
            // Light theme
            BG.backgroundColor = UIColor.white
//            InfoButton.setTitleColor(UIColor.black, for: .normal)
//            SettingsButton.setTitleColor(UIColor.black, for: .normal)
            SettingsButton.tintColor = customPink
            InfoButton.tintColor = customPink
            overrideUserInterfaceStyle = .light
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
}
