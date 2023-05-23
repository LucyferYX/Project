//
//  SoundViewController.swift
//  Project
//
//  Created by liene.krista.neimane on 23/05/2023.
//

import UIKit

// Add these structures to match the JSON response structure
struct SoundResponse: Codable {
    let results: [Sound]
}

struct Sound: Codable {
    let id: Int
    let name: String
}

class SoundViewController: UITableViewController {
    var sounds: [Sound] = []
    var selectedSounds: Set<Int> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSounds()
    }

    func fetchSounds() {
        let url = URL(string: "https://freesound.org/apiv2/search/text/?query=water&token=iQMs8GdHg9K0nFXUTXUlE7baFrfQCeER6FFQNImu")!
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! SoundCell
        let sound = sounds[indexPath.row]
        
        cell.soundLabel.text = sound.name
        cell.soundSwitch.isOn = selectedSounds.contains(sound.id)
        cell.soundSwitch.tag = sound.id
        cell.soundSwitch.addTarget(self, action: #selector(soundSwitchChanged), for: .valueChanged)

        // Making the switch size a bit smaller
        cell.soundSwitch.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        return cell
    }
    
    @objc func soundSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            selectedSounds.insert(sender.tag)
        } else {
            selectedSounds.remove(sender.tag)
        }
        
        print("Selected sounds: \(selectedSounds)")
    }
}
