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
    @IBOutlet weak var CreditsLabel2: UILabel!
    @IBOutlet weak var LinkLabel2: UILabel!
    
    let customGreen = UIColor(red: 36/255, green: 79/255, blue: 37/255, alpha: 1)
    weak var delegate: SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.black : UIColor.white
        ColourLabel.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        BrightnessLabel.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        VolumeLabel.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        CreditsLabel.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        CreditsLabel2.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        LinkLabel.textColor = customGreen
        LinkLabel2.textColor = customGreen
        setupLinkLabel()
        setupLinkLabel2()
        setupBrightnessSlider()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = AppearanceManager.shared.backgroundColor
        setupBrightnessSlider()
        setupVolumeSlider()
        ColourSegment.selectedSegmentIndex = AppearanceManager.shared.selectedColorIndex
        delegate?.didUpdateSettings()
    }
    
    
    // Changes colours
    @IBAction func colorSegmentValueChanged(_ sender: UISegmentedControl) {
        let selectedColorIndex = sender.selectedSegmentIndex
        AppearanceManager.shared.selectedColorIndex = selectedColorIndex
        view.backgroundColor = AppearanceManager.shared.backgroundColor
        delegate?.didUpdateSettings()
    }
    
    
    // Changes brightness
    // ON SIMULATOR THE BRIGHTNESS WON'T CHANGE!
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
    
    
    // Links with animation upon being clicked
    private func setupLinkLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkTapped))
        LinkLabel.isUserInteractionEnabled = true
        LinkLabel.addGestureRecognizer(tapGesture)
        LinkLabel.attributedText = NSAttributedString(string: "Freesound.org", attributes: [NSAttributedString.Key.foregroundColor: customGreen])
    }
    
    private func setupLinkLabel2() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkTapped2))
        LinkLabel2.isUserInteractionEnabled = true
        LinkLabel2.addGestureRecognizer(tapGesture)
        LinkLabel2.attributedText = NSAttributedString(string: "Unsplash.com", attributes: [NSAttributedString.Key.foregroundColor: customGreen])
    }
    
    @objc private func linkTapped() {
        let attributedString = NSMutableAttributedString(string: LinkLabel.text ?? "")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: NSRange(location: 0, length: attributedString.length))
        LinkLabel.attributedText = attributedString
        
        if let url = URL(string: "https://freesound.org") {
            UIApplication.shared.open(url)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let attributedString = NSMutableAttributedString(string: self.LinkLabel.text ?? "")
            attributedString.addAttribute(.underlineStyle, value: 0, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 0, length: attributedString.length))
            self.LinkLabel.attributedText = attributedString
        }
    }
    
    @objc private func linkTapped2() {
        let attributedString = NSMutableAttributedString(string: LinkLabel2.text ?? "")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: NSRange(location: 0, length: attributedString.length))
        LinkLabel2.attributedText = attributedString
        
        if let url = URL(string: "https://unsplash.com") {
            UIApplication.shared.open(url)
        }
        
        // Reverting label after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let attributedString = NSMutableAttributedString(string: self.LinkLabel2.text ?? "")
            attributedString.addAttribute(.underlineStyle, value: 0, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 0, length: attributedString.length))
            self.LinkLabel2.attributedText = attributedString
        }
    }
}
