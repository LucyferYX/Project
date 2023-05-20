//
//  MainViewController.swift
//  Project
//
//  Created by liene.krista.neimane on 19/05/2023.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func InfoButton(_ sender: UIButton) {
        
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
}

