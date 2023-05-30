//
//  AppDelegate.swift
//  Project
//
//  Created by liene.krista.neimane on 19/05/2023.
//

import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Sound player
    var window: UIWindow?
    
    var soundPlayers: [String: AVAudioPlayer] = [:] // Moved from SoundViewController
    
    func playSoundLoop(soundName: String) {
        if let player = soundPlayers[soundName] {
            player.stop()
        }
        
        let fileTypes = ["mp3", "wav", "m4a"]
        
        for fileType in fileTypes {
            if let soundURL = Bundle.main.url(forResource: "Sounds/\(soundName)", withExtension: fileType) {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    let player = try AVAudioPlayer(contentsOf: soundURL, fileTypeHint: AVFileType.init(rawValue: fileType).rawValue)
                    player.numberOfLoops = -1 // Loop indefinitely
                    player.play()
                    soundPlayers[soundName] = player
                    return
                } catch {
                    print("Unable to create audio player for sound: \(soundName)")
                }
            }
        }
        
        print("Sound file not found for sound: \(soundName)")
    }
    
    func stopSoundLoop(soundName: String) {
        if let player = soundPlayers[soundName] {
            player.stop()
            soundPlayers.removeValue(forKey: soundName)
        }
    }
    
    
    // Other AppDelegate code

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

