//
//  SettingsViewController.swift
//  Project
//
//  Created by liene.krista.neimane on 20/05/2023.
//

import UIKit
// MP for volume adjustment
import MediaPlayer

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var ColourLabel: UILabel!
    @IBOutlet weak var ColourSegment: UISegmentedControl!
    @IBOutlet weak var BrightnessLabel: UILabel!
    @IBOutlet weak var BrightnessSlider: UISlider!
    @IBOutlet weak var VolumeLabel: UILabel!
    @IBOutlet weak var VolumeSlider: UISlider!
    @IBOutlet weak var CreditsLabel: UILabel!
    @IBOutlet weak var LinkLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.black : UIColor.white
        BrightnessLabel.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        VolumeLabel.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        CreditsLabel.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        CreditsLabel.textColor = UIColor.green
        setupLinkLabel()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBrightnessSlider()
        setupVolumeSlider()
    }
    
    
    // Changes brightness
    @IBAction func brightnessSliderValue(_ sender: UISlider) {
        let brightnessValue = sender.value
        UIScreen.main.brightness = CGFloat(brightnessValue)
    }
    
    func setupBrightnessSlider() {
        let currentBrightness = UIScreen.main.brightness
        BrightnessSlider.value = Float(currentBrightness)
    }

    @IBAction func brightnessSliderValueChanged(_ sender: UISlider) {
        let brightnessValue = sender.value
        UIScreen.main.brightness = CGFloat(brightnessValue)
    }

    
    // Changes volume
    func setupVolumeSlider() {
        let volumeView = MPVolumeView()
        for view in volumeView.subviews {
            if let slider = view as? UISlider {
                VolumeSlider.value = slider.value
                break
            }
        }
    }

    @IBAction func volumeSliderValueChanged(_ sender: UISlider) {
        let volume = sender.value
        let volumeView = MPVolumeView()
        for view in volumeView.subviews {
            if let slider = view as? UISlider {
                slider.value = volume
                break
            }
        }
    }
    
    
    // Link
    private func setupLinkLabel() {
        let linkText = "Freesound"
        let attributedString = NSAttributedString(string: linkText, attributes: [.link: URL(string: linkText)!])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkTapped(_:)))

        LinkLabel.attributedText = attributedString
        LinkLabel.isUserInteractionEnabled = true
        LinkLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func linkTapped(_ gesture: UITapGestureRecognizer) {
        if let url = URL(string: "https://freesound.org") {
            UIApplication.shared.open(url)
        }
    }

}
