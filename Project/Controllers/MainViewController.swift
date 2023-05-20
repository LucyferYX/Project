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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func InfoButtonTap(_ sender: UIButton) {
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
        if sender.isOn {
                // Dark theme
                BG.backgroundColor = UIColor.black
                InfoButton.setTitleColor(UIColor.white, for: .normal)
                SettingsButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                // Light theme
                BG.backgroundColor = UIColor.white
                InfoButton.setTitleColor(UIColor.black, for: .normal)
                SettingsButton.setTitleColor(UIColor.black, for: .normal)
            }
    }
    
}

