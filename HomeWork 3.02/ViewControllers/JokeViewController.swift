//
//  JokeViewController.swift
//  HomeWork 3.02
//
//  Created by Альбина Лега on 09.11.2022.
//

import UIKit

final class JokeViewController: UIViewController {
    @IBOutlet var setupLabel: UILabel!
    @IBOutlet var deliveryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGreenBackgroundColor()

        
    }
    
    @IBAction func oneMoreButtonPressed() {
    }
}
