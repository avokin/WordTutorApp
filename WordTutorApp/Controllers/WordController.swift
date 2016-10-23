//
// Created by Andrey Vokin on 10/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

class WordController: UITableViewController {
    var word: Word? = nil

    var translations_section = -1
    var related_words_section = -1
    var categories_section = -1
    var comment_section = -1
    var section_count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.title = word!.text

        if self.word!.translations.count > 0 {
            self.translations_section = 0
            self.section_count += 1
        }

        if self.word!.synonyms.count > 0 {
            self.related_words_section = self.section_count
            self.section_count += 1
        }

        if self.word!.categories.count > 0 {
            self.categories_section = self.section_count
            self.section_count += 1
        }

        if self.word!.comment.characters.count > 0 {
            comment_section = self.section_count
            self.section_count += 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == translations_section {
            return word!.translations.count
        } else if section == related_words_section {
            return word!.synonyms.count
        } else if section == categories_section {
            return word!.categories.count
        } else {
            if word!.comment.characters.count > 0 {
                return 1
            }
            return 0
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.section_count
    }

    override internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == translations_section {
            return "Translations"
        }
        if section == related_words_section {
            return "Related words"
        }
        if section == categories_section {
            return "Categories"
        }
        return "Comment"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if (indexPath as NSIndexPath).section == translations_section {
            cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
            cell.textLabel!.text = word!.translations[(indexPath as NSIndexPath).row].text
            cell.tag = word!.translations[(indexPath as NSIndexPath).row].id
        } else if (indexPath as NSIndexPath).section == related_words_section {
            cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
            cell.textLabel!.text = word!.synonyms[(indexPath as NSIndexPath).row].text
            cell.tag = word!.synonyms[(indexPath as NSIndexPath).row].id
        } else if (indexPath as NSIndexPath).section == categories_section {
            cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
            cell.textLabel!.text = word!.categories[(indexPath as NSIndexPath).row].name
            cell.tag = word!.categories[(indexPath as NSIndexPath).row].id
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "Other", for: indexPath)
            cell.textLabel!.text = word!.comment
            cell.tag = 0
        }

        return cell
    }

    @available(iOS 5.0, *) override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CategoryController {
            let categoryWordsController = segue.destination as! CategoryController
            categoryWordsController.category = Category.ids[(sender as! UITableViewCell).tag]
        } else {
            let wordController = segue.destination as! WordController
            wordController.word = Word.ids[(sender as! UITableViewCell).tag]
        }
    }
}
