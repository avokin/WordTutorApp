//
//  PhotoViewController.swift
//  WordTutorApp
//
//  Created by Andrey Vokin on 22/02/16
//  Copyright (c) 2015 avokin. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}
