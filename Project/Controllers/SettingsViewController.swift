//
//  SettingsViewController.swift
//  Project
//
//  Created by liene.krista.neimane on 20/05/2023.
//

import UIKit
import MediaPlayer
import AVFoundation

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var ColourLabel: UILabel!
    @IBOutlet weak var ColourSegment: UISegmentedControl!
    @IBOutlet weak var TestLabel: UILabel!
    @IBOutlet weak var TestButton: UIButton!
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
        TestLabel.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        VolumeLabel.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        CreditsLabel.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        CreditsLabel2.textColor = AppearanceManager.shared.isDarkModeEnabled ? UIColor.white : UIColor.black
        LinkLabel.textColor = customGreen
        LinkLabel2.textColor = customGreen
        setupLinkLabel()
        setupLinkLabel2()
        if AppearanceManager.shared.isDarkModeEnabled {
            ColourSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        } else {
            ColourSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = AppearanceManager.shared.backgroundColor
        setupVolumeSlider()
        ColourSegment.selectedSegmentIndex = AppearanceManager.shared.selectedColorIndex
        delegate?.didUpdateSettings()
        if AppearanceManager.shared.isDarkModeEnabled {
            ColourSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        } else {
            ColourSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        }
    }
    
    
    // Changes colours
    @IBAction func colorSegmentValueChanged(_ sender: UISegmentedControl) {
        let selectedColorIndex = sender.selectedSegmentIndex
        AppearanceManager.shared.selectedColorIndex = selectedColorIndex
        view.backgroundColor = AppearanceManager.shared.backgroundColor

        if AppearanceManager.shared.isDarkModeEnabled {
            // Dark mode is on
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            ColourSegment.setTitleTextAttributes(titleTextAttributes, for: .normal)
        } else {
            // Dark mode is off
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            ColourSegment.setTitleTextAttributes(titleTextAttributes, for: .normal)
        }

        delegate?.didUpdateSettings()
    }
    
    
    // Tests sound with button
    var audioPlayer: AVAudioPlayer?
    
    @IBAction func testButtonTapped(_ sender: UIButton) {
        playSound()
    }
    
    func playSound() {
        if let soundURL = Bundle.main.url(forResource: "Sounds/test", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.volume = audioVolume
                audioPlayer?.play()
            } catch {
                print("Failed to load sound file.")
            }
        } else {
            print("Unable to find sound file.")
        }
    }


    
    // Changes volume
    var audioVolume: Float = 0.5
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
        audioVolume = sender.value
        if let player = audioPlayer, player.isPlaying {
            player.volume = audioVolume
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
