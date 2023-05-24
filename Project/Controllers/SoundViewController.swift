//
//  SoundViewController.swift
//  Project
//
//  Created by liene.krista.neimane on 23/05/2023.
//

import UIKit
// AVFoundation will allow for sounds to be looped
import AVFoundation

struct SoundResponse: Codable {
    let results: [Sound]
}

struct Sound: Codable {
    let id: Int
    let name: String
}

class SoundViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var sounds: [Sound] = []
    var selectedSounds: Set<Int> = []
    var soundPlayers: [Int: AVAudioPlayer] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSounds()
        searchBar.delegate = self
        view.backgroundColor = AppearanceManager.shared.backgroundColor
        customizeSearchBar()
    }
    
    // Search based on the entered text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSounds(query: searchText)
    }
    
    private func customizeSearchBar() {
        let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchBar.barTintColor = AppearanceManager.shared.searchBarColor
        searchBarTextField?.textColor = AppearanceManager.shared.searchBarTextColor
    }
    
    // Clearing search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchSounds(query: nil)
    }

    func searchSounds(query: String?) {
        // Filter the sounds based on the search query
        if let query = query, !query.isEmpty {
            // Filter sounds by name containing the query
            let filteredSounds = sounds.filter {
                $0.name.lowercased().contains(query.lowercased())
            }
            displaySounds(filteredSounds)
        } else {
            // No query or empty query, display all sounds
            displaySounds(sounds)
        }
    }
    
    func displaySounds(_ soundsToDisplay: [Sound]) {
        // Update the table view with the filtered sounds
        sounds = soundsToDisplay
        tableView.reloadData()
    }
    
    // Using my personal API key to access
    func fetchSounds() {
        let keywords = "rain,forest,birds,leaves,rain"
        let query = keywords.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://freesound.org/apiv2/search/text/?query=\(query)&token=iQMs8GdHg9K0nFXUTXUlE7baFrfQCeER6FFQNImu"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Token iQMs8GdHg9K0nFXUTXUlE7baFrfQCeER6FFQNImu", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching sounds: \(error)")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let soundResponse = try decoder.decode(SoundResponse.self, from: data)
                    self.sounds = soundResponse.results
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath)
        let sound = sounds[indexPath.row]

        if let soundCell = cell as? SoundCell {
            let isSelected = SoundStateManager.shared.isSelected(sound.id)
            soundCell.configure(with: sound, isSelected: isSelected)
            soundCell.isDarkModeEnabled = AppearanceManager.shared.isDarkModeEnabled

            // Making the switch size a bit smaller
            soundCell.soundSwitch.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            soundCell.soundSwitch.addTarget(self, action: #selector(soundSwitchChanged(_:)), for: .valueChanged)
            soundCell.soundSwitch.tag = sound.id
        }

        return cell
    }

    
    @objc func soundSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            selectedSounds.insert(sender.tag)
            playSoundLoop(soundID: sender.tag)
        } else {
            selectedSounds.remove(sender.tag)
            stopSoundLoop(soundID: sender.tag)
        }
        
        // Updating the selected sounds
        SoundStateManager.shared.setSelectedSounds(selectedSounds)
        print("Selected sounds: \(selectedSounds)")
    }
    
    func playSoundLoop(soundID: Int) {
        if let player = soundPlayers[soundID] {
            player.stop()
        }
        
        // Get the URL of the sound file
        guard let soundURL = Bundle.main.url(forResource: "sound\(soundID)", withExtension: "mp3") else {
            print("Sound file not found for sound ID: \(soundID)")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: soundURL)
            // Loop count is -1 for infinite looping
            player.numberOfLoops = -1
            player.play()
            soundPlayers[soundID] = player
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    
    func stopSoundLoop(soundID: Int) {
        if let player = soundPlayers[soundID] {
            player.stop()
            soundPlayers.removeValue(forKey: soundID)
        }
    }
}

// For making sure the sounds stay selected
class SoundStateManager {
    static let shared = SoundStateManager()
    
    private let selectedSoundsKey = "SelectedSounds"
    private var selectedSounds: Set<Int> = []
    
    private init() {
        loadSelectedSounds()
    }
    
    func isSelected(_ soundID: Int) -> Bool {
        return selectedSounds.contains(soundID)
    }
    
    func setSelectedSounds(_ sounds: Set<Int>) {
        selectedSounds = sounds
        saveSelectedSounds()
    }
    
    private func saveSelectedSounds() {
        UserDefaults.standard.set(Array(selectedSounds), forKey: selectedSoundsKey)
    }
    
    private func loadSelectedSounds() {
        if let selectedSoundsArray = UserDefaults.standard.array(forKey: selectedSoundsKey) as? [Int] {
            selectedSounds = Set(selectedSoundsArray)
        }
    }
}
