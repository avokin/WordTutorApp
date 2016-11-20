//
// Created by Andrey Vokin on 10/11/2016.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class AddWordController: UITableViewController, UITextFieldDelegate {
    var wordCell: TextFieldTableViewCell?
    var grammarCell: GrammarTableViewCell?

    var word = Word(dictionary: NSMutableDictionary())

    let wordSection = 0
    let grammarSection = 1
    let translationsSection = 2
    let categoriesSection = 3
    let relatedWordsSection = 4
    let commentSection = 5

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
    }

    override internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == wordSection {
            return "Word"
        }
        if section == grammarSection {
            return "Grammar"
        }
        if section == translationsSection {
            return "Translations"
        }
        if section == categoriesSection {
            return "Categories"
        }
        if section == relatedWordsSection {
            return "Related words"
        }
        if section == commentSection {
            return "Comment"
        }

        return nil
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == wordSection {
            return 1
        }
        if section == grammarSection {
            return 1
        }
        if section == translationsSection {
            return word.translations.count + 1
        }
        if section == categoriesSection {
            return word.categories.count + 1
        }
        if section == relatedWordsSection {
            return 1
        }
        if section == commentSection {
            return 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = (indexPath as NSIndexPath).section
        let row = (indexPath as NSIndexPath).row

        if section == wordSection {
            wordCell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            return wordCell!
        }
        if section == grammarSection {
            if word.typeId == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "GermanNounGrammarTableViewCell", for: indexPath) as! GermanNounGrammarTableViewCell
                cell.scPartOfSpeech.selectedSegmentIndex = word.typeId - 1
                cell.scGender.selectedSegmentIndex = word.customIntField1 - 1
                cell.txtPlural.text = word.customStringField1

                cell.scGender.addTarget(self, action: #selector(customIntField1Changed(sender:)), for: .valueChanged)
                cell.scPartOfSpeech.addTarget(self, action: #selector(partOfSpeechChanged(sender:)), for: .valueChanged)

                grammarCell = cell;
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "GrammarTableViewCell", for: indexPath) as! GrammarTableViewCell
                cell.scPartOfSpeech.selectedSegmentIndex = word.typeId - 1
                cell.scPartOfSpeech.addTarget(self, action: #selector(partOfSpeechChanged(sender:)), for: .valueChanged)

                grammarCell = cell;
                return cell
            }
        }
        if section == translationsSection {
            if row < word.translations.count {
                return createRemovableLabelCell(text: word.translations[row].text, indexPath: indexPath, selector: #selector(removeTranslationPressed(sender:)))
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldWithButtonTableViewCell", for: indexPath) as! TextFieldWithButtonTableViewCell
            cell.button.removeTarget(nil, action: nil, for: .allEvents)
            cell.button.addTarget(self, action: #selector(addTranslationPressed(sender:)), for: .touchUpInside)
            cell.button.setTitle("Add", for: .normal)
            return cell
        }
        if section == categoriesSection {
            if row < word.categories.count {
                return createRemovableLabelCell(text: word.categories[row].name, indexPath: indexPath, selector: #selector(removeCategoryPressed(sender:)))
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldWithButtonTableViewCell", for: indexPath) as! TextFieldWithButtonTableViewCell
            cell.button.removeTarget(nil, action: nil, for: .allEvents)
            cell.button.addTarget(self, action: #selector(addCategoryPressed(sender:)), for: .touchUpInside)
            cell.button.setTitle("Add", for: .normal)
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath)
    }

    func createRemovableLabelCell(text: String, indexPath: IndexPath, selector: Selector) -> UITableViewCell {
        let row = (indexPath as NSIndexPath).row

        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelWithButtonTableViewCell", for: indexPath) as! LabelWithButtonTableViewCell
        cell.tag = row

        cell.label.text = text

        cell.button.tag = row
        cell.button.setTitle("Remove", for: .normal)

        cell.button.removeTarget(nil, action: nil, for: .allEvents)
        cell.button.addTarget(self, action: selector, for: .touchUpInside)
        return cell
    }

    func partOfSpeechChanged(sender: UISegmentedControl!) {
        word.setTypeId(typeId: sender.selectedSegmentIndex + 1)
        tableView.reloadData()
    }

    func customIntField1Changed(sender: UISegmentedControl!) {
        word.setCustomIntField1(customIntField1: sender.selectedSegmentIndex + 1)
        tableView.reloadData()
    }

    func addTranslationPressed(sender: UIButton!) {
        let cell = sender.superview!.superview! as! TextFieldWithButtonTableViewCell
        if cell.textField.text != nil && cell.textField.text!.characters.count > 0 {
            let translationWord = Word(dictionary: NSMutableDictionary())
            translationWord.setText(text: cell.textField.text!)
            word.translations.append(translationWord)
            cell.textField.text = ""
            tableView.reloadData()
        }
    }

    func removeTranslationPressed(sender: UIButton!) {
        word.translations.remove(at: sender.tag)
        tableView.reloadData()
    }

    func addCategoryPressed(sender: UIButton!) {
        let cell = sender.superview!.superview! as! TextFieldWithButtonTableViewCell
        if cell.textField.text != nil && cell.textField.text!.characters.count > 0 {
            // ToDo: make method find
            let category = Category(dictionary: NSMutableDictionary())
            category.name = cell.textField.text!
            word.categories.append(category)
            cell.textField.text = ""
            tableView.reloadData()
        }
    }

    func removeCategoryPressed(sender: UIButton!) {
        word.categories.remove(at: sender.tag)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && word.getTypeId() == 2 {
            return 117
        }
        return 44;
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func saveWord(_ sender: Any) {
        word.setText(text: wordCell!.textField.text!)
        word.typeId = grammarCell!.scPartOfSpeech.selectedSegmentIndex

        DataProvider.getInstance().addWord(word: word, callback: {(jsonDict: NSDictionary) in
                    print(jsonDict)
                })
    }
    
    @IBAction func loadWord(_ sender: Any) {
        word.setText(text: wordCell!.textField.text!)
        if word.getText().characters.count == 0 {
            return
        }
        DataProvider.getInstance().requestWord(word: word.text, callback: {(jsonDict: NSDictionary) in
                    let translationStrings = jsonDict["translations"]
                    let translations = translationStrings as! Array<String>
                    for s: String in translations {
                        let translationWord = Word(dictionary: NSMutableDictionary())
                        translationWord.setText(text: s)
                        self.word.translations.append(translationWord)
                    }

                    self.word.typeId = (jsonDict["type_id"] as! NSNumber).intValue
                    self.word.customIntField1 = (jsonDict["custom_int_field1"] as! NSNumber).intValue
                    self.word.customStringField1 = jsonDict["custom_string_field1"] as! String

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
    }
}
