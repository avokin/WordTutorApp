//
// Created by Andrey Vokin on 02/09/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class LoginController : UIViewController {
    @IBAction func loginAction(sender: AnyObject) {
        self.performSegueWithIdentifier("loginSuccessful", sender: self)
    }
}
