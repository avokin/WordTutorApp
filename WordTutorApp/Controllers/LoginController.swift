//
// Created by Andrey Vokin on 02/09/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class LoginController : UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        LoginHelper.getInstance().setAuthorizationToken(nil)
    }

    @IBAction func loginAction(_ sender: AnyObject) {
        let url = URL(string: DataProvider.HOST + "sessions.json?session[email]=" + usernameField.text! +
                "&session[password]=" + passwordField.text!)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            if (error != nil) {
                self.errorLabel.text = error!.localizedDescription;
                return;
            }
            let responseBody = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            let JSONData = responseBody!.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)
            let JSONDictionary = try! JSONSerialization.jsonObject(with: JSONData!, options: []) as! NSDictionary

            if (JSONDictionary["error"] != nil) {
                OperationQueue.main.addOperation {
                    self.errorLabel.text = JSONDictionary["error"] as? String;
                }
                return;
            }

            LoginHelper.getInstance().setAuthorizationToken(JSONDictionary["token"] as? String)

            OperationQueue.main.addOperation {
                self.performSegue(withIdentifier: "loginSuccessful", sender: self)
            }
        }) 

        task.resume()
    }
}
