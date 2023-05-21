//
//  JumpButton.swift
//  Project
//
//  Created by liene.krista.neimane on 22/05/2023.
//

import UIKit

class JumpButton: UIButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 0.9)
        
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 5, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
        super.touchesBegan(touches, with: event)
    }
}
