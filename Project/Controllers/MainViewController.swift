//
//  MainViewController.swift
//  Project
//
//  Created by liene.krista.neimane on 19/05/2023.
//

import UIKit

// Settings is connected by modal view, the background colour won't immediately change
protocol SettingsDelegate: AnyObject {
    func didUpdateSettings()
}

extension MainViewController: SettingsDelegate {
    func didUpdateSettings() {
        view.backgroundColor = AppearanceManager.shared.backgroundColor
        darkThemeIsOn(isOn: ThemeSwitch.isOn)
    }
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var ThemeSwitch: UISwitch!
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var InfoButton: UIButton!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var Photos: UIImageView!
    @IBOutlet weak var SoundLabel: UILabel!
    
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
        loadImages()
        updateImageTransition()
        stylePhotos()
        SoundLabel.alpha = 0.9
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = AppearanceManager.shared.backgroundColor
        darkThemeIsOn(isOn: ThemeSwitch.isOn)
    }
    
    // Segue action will trigger Main view to do any action, like change background color, otherwise modal view does not count in viewDidLoad
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSettingsSegue", let settingsViewController = segue.destination as? SettingsViewController {
            settingsViewController.delegate = self
        }
    }
    
    // Immediate update for background
    @IBAction func themeSwitchValueChanged(_ sender: UISwitch) {
        darkThemeIsOn(isOn: sender.isOn)
        view.backgroundColor = AppearanceManager.shared.backgroundColor
    }
    
    // Info button will display information about this project
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    @IBAction func InfoButtonTap(_ sender: UIButton) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        let dateString = formatter.string(from: date)
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            basicActionAlert(title: "App information", message: "Creator: Liene Krista Neimane\nDate: \(dateString)\nCourse: iOS Bootcamp\nv\(appVersion)")
        } else {
            basicActionAlert(title: "App information", message: "Creator: Liene Krista Neimane\nDate: \(dateString)\nCourse: iOS Bootcamp\nVersion information not available")
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
        AppearanceManager.shared.isDarkModeEnabled = sender.isOn
        darkThemeIsOn(isOn: sender.isOn)
    }
    
    func darkThemeIsOn(isOn: Bool){
        AppearanceManager.shared.isDarkModeEnabled = isOn
        if isOn {
            // Dark theme
            BG.backgroundColor = UIColor.black
            SettingsButton.tintColor = customGreen
            InfoButton.tintColor = customGreen
            TitleLabel.textColor = customYellow
            SoundLabel.textColor = customYellow
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
            SoundLabel.textColor = customBlue
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
    
    
    // Appearance for Photos
    func stylePhotos() {
        // Clip to bounds allows to have rounded corners
        Photos.layer.cornerRadius = 20
        Photos.clipsToBounds = true
        Photos.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }

    
    // Showcasing images in main screen
    var images: [UIImage] = []
    var imagesShuffle: [UIImage] = []
    var imgIndex = 0
    var timer: Timer?
    
    func loadImages() {
        images.append(UIImage(named: "image1")!)
        images.append(UIImage(named: "image2")!)
        images.append(UIImage(named: "image3")!)
        images.append(UIImage(named: "image4")!)
        images.append(UIImage(named: "image5")!)
        images.append(UIImage(named: "image6")!)
        imagesShuffle = images.shuffled()
    }
    
    func startTransitioningImages() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            let toImage = self.imagesShuffle[self.imgIndex]
            UIView.transition(with: self.Photos,
                              duration: 1.0,
                              options: .transitionCrossDissolve,
                              animations: { self.Photos.image = toImage },
                              completion: nil)

            // Update the index, reshuffle the images if end is reached
            self.imgIndex += 1
            if self.imgIndex >= self.imagesShuffle.count {
                self.imgIndex = 0
                self.imagesShuffle = self.images.shuffled()
            }
        }
    }
    
    func stopTransitioningImages() {
        timer?.invalidate()
        timer = nil
    }
    
    // The length of image showcase
    func updateImageTransition() {
        startTransitioningImages()
        UIView.animate(withDuration: 1.0) {
            self.SoundLabel.alpha = 0.9
        }
    }
    
}
