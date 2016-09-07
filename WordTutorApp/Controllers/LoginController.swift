//
// Created by Andrey Vokin on 02/09/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class LoginController : UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!

    @IBAction func loginAction(sender: AnyObject) {
        let url = NSURL(string: "http://127.0.0.1:3000/sessions.json?session[email]=" + passwordField.text! + "&session[password]=" + passwordField.text!)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            let responseBody = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let JSONData = responseBody!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            let JSONDictionary = try! NSJSONSerialization.JSONObjectWithData(JSONData!, options: []) as! NSDictionary
            if JSONDictionary["error"] == nil {
                LoginHelper.getInstance().authorisationToken = JSONDictionary["token"] as! String
                self.performSegueWithIdentifier("loginSuccessful", sender: self)
            }
        }

        task.resume()
    }
}
