//
// Created by Andrey Vokin on 10/11/2016.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class AddWordController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var customIntField: UIPickerView!

    var translations = [String]()
    var partOfSpeech = 2
    var customIntField1 = 2
    var customStringField1 = ""

    override func viewDidLoad() {
        super.viewDidLoad()

//        txtQuery.delegate = self
//        textViewComment.layer.borderWidth = 0.5
//        textViewComment.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
//        textViewComment.layer.cornerRadius = 5

        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldTableViewCell")
        tableView.register(UINib(nibName: "GermanNounGrammarTableViewCell", bundle: nil), forCellReuseIdentifier: "GermanNounGrammarTableViewCell")
        tableView.register(UINib(nibName: "GrammarTableViewCell", bundle: nil), forCellReuseIdentifier: "GrammarTableViewCell")
        tableView.register(UINib(nibName: "TextFieldWithButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldWithButtonTableViewCell")
        tableView.register(UINib(nibName: "LabelWithButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "LabelWithButtonTableViewCell")

        translations = ["собака", "псина", "пес"]
        customIntField1 = 2
        customStringField1 = "-en"
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
        return translations.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = (indexPath as NSIndexPath).section
        let row = (indexPath as NSIndexPath).row

        if section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath)
        } else if section == 1 {
            if partOfSpeech == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "GermanNounGrammarTableViewCell", for: indexPath) as! GermanNounGrammarTableViewCell
                cell.scPartOfSpeech.selectedSegmentIndex = partOfSpeech - 1
                cell.scGender.selectedSegmentIndex = customIntField1 - 1
                cell.txtPlural.text = customStringField1

                cell.scGender.addTarget(self, action: #selector(customIntField1Changed(sender:)), for: .valueChanged)
                cell.scPartOfSpeech.addTarget(self, action: #selector(partOfSpeechChanged(sender:)), for: .valueChanged)

                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "GrammarTableViewCell", for: indexPath) as! GrammarTableViewCell
                cell.scPartOfSpeech.selectedSegmentIndex = partOfSpeech - 1
                cell.scPartOfSpeech.addTarget(self, action: #selector(partOfSpeechChanged(sender:)), for: .valueChanged)

                return cell
            }
        }
        if section == 2 {
            if row < translations.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LabelWithButtonTableViewCell", for: indexPath) as! LabelWithButtonTableViewCell
                cell.tag = row

                cell.label.text = translations[row]

                cell.button.tag = row
                cell.button.setTitle("Remove", for: .normal)
                cell.button.addTarget(self, action: #selector(removeTranslationPressed(sender:)), for: .touchUpInside)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldWithButtonTableViewCell", for: indexPath) as! TextFieldWithButtonTableViewCell
            cell.button.addTarget(self, action: #selector(addTranslationPressed(sender:)), for: .touchUpInside)
            cell.button.setTitle("Add", for: .normal)
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "GermanNounTableViewCell", for: indexPath)
    }

    func partOfSpeechChanged(sender: UISegmentedControl!) {
        partOfSpeech = sender.selectedSegmentIndex + 1
        tableView.reloadData()
    }

    func customIntField1Changed(sender: UISegmentedControl!) {
        customIntField1 = sender.selectedSegmentIndex + 1
        tableView.reloadData()
    }

    func addTranslationPressed(sender: UIButton!) {
        let cell = sender.superview!.superview! as! TextFieldWithButtonTableViewCell
        if cell.textField.text != nil && cell.textField.text!.characters.count > 0 {
            translations.append(cell.textField.text!)
            cell.textField.text = ""
            tableView.reloadData()
        }
    }

    func removeTranslationPressed(sender: UIButton!) {
        translations.remove(at: sender.tag)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && partOfSpeech == 2 {
            return 117
        }
        return 44;
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
