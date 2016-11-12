//
// Created by Andrey Vokin on 10/11/2016.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class AddWordController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var customIntField: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        txtQuery.delegate = self
//        textViewComment.layer.borderWidth = 0.5
//        textViewComment.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
//        textViewComment.layer.cornerRadius = 5

        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldTableViewCell")
        tableView.register(UINib(nibName: "GermanNounGrammarTableViewCell", bundle: nil), forCellReuseIdentifier: "GermanNounGrammarTableViewCell")
        tableView.register(UINib(nibName: "TextFieldWithButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldWithButtonTableViewCell")
        tableView.register(UINib(nibName: "LabelWithButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "LabelWithButtonTableViewCell")
    }

    override internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Word"
        }
        if section == 1 {
            return "Grammar"
        }
        if section == 2 {
            return "Translations"
        }
        return nil
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = (indexPath as NSIndexPath).section
        let row = (indexPath as NSIndexPath).row

        if section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath)
        } else if section == 1 {
            if row == 0 {
                return tableView.dequeueReusableCell(withIdentifier: "GermanNounGrammarTableViewCell", for: indexPath)
            } else {
                return tableView.dequeueReusableCell(withIdentifier: "GermanNounGrammarTableViewCell", for: indexPath)
            }
        }
        if section == 2 {
            if row < 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LabelWithButtonTableViewCell", for: indexPath) as! LabelWithButtonTableViewCell
                cell.button.setTitle("Remove", for: .normal)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldWithButtonTableViewCell", for: indexPath) as! TextFieldWithButtonTableViewCell
            cell.button.setTitle("Add", for: .normal)
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "GermanNounTableViewCell", for: indexPath)
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 117
        }
        return 44;
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
