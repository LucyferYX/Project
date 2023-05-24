//
//  SoundCell.swift
//  Project
//
//  Created by liene.krista.neimane on 23/05/2023.
//

import UIKit

class SoundCell: UITableViewCell {
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var soundSwitch: UISwitch!
    
    var isDarkModeEnabled: Bool = false {
        didSet {
            updateCellAppearance()
        }
    }

    func configure(with sound: Sound, isSelected: Bool) {
        soundLabel.text = sound.name
        soundSwitch.isOn = isSelected
        updateCellAppearance()
    }

    private func updateCellAppearance() {
        contentView.backgroundColor = isDarkModeEnabled ? UIColor.black : UIColor.white
        soundLabel.textColor = isDarkModeEnabled ? UIColor.white : UIColor.black
    }
}
