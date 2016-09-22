//
// Created by Andrey Vokin on 02/09/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class LoginController : UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    @IBAction func loginAction(sender: AnyObject) {
        let url = NSURL(string: DataProvider.HOST + "sessions.json?session[email]=" + usernameField.text! +
                "&session[password]=" + passwordField.text!)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            if (error != nil) {
                self.errorLabel.text = error!.localizedDescription;
                return;
            }
            let responseBody = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let JSONData = responseBody!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            let JSONDictionary = try! NSJSONSerialization.JSONObjectWithData(JSONData!, options: []) as! NSDictionary

            if (JSONDictionary["error"] != nil) {
                self.errorLabel.text = JSONDictionary["error"] as! String;
                return;
            }

            LoginHelper.getInstance().authorisationToken = JSONDictionary["token"] as! String

            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.performSegueWithIdentifier("loginSuccessful", sender: self)
            }
        }

        task.resume()
    }
}
