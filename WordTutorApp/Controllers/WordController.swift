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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.section_count
    }

    override internal func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == translations_section {
            cell = tableView.dequeueReusableCellWithIdentifier("Word", forIndexPath: indexPath)
            cell.textLabel!.text = word!.translations[indexPath.row].text
            cell.tag = word!.translations[indexPath.row].id
        } else if indexPath.section == related_words_section {
            cell = tableView.dequeueReusableCellWithIdentifier("Word", forIndexPath: indexPath)
            cell.textLabel!.text = word!.synonyms[indexPath.row].text
            cell.tag = word!.synonyms[indexPath.row].id
        } else if indexPath.section == categories_section {
            cell = tableView.dequeueReusableCellWithIdentifier("Category", forIndexPath: indexPath)
            cell.textLabel!.text = word!.categories[indexPath.row].name
            cell.tag = word!.categories[indexPath.row].id
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("Other", forIndexPath: indexPath)
            cell.textLabel!.text = word!.comment
            cell.tag = 0
        }

        return cell
    }

    @available(iOS 5.0, *) override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is WordListController {
            let wordListController = segue.destinationViewController as! WordListController
            wordListController.words = Category.ids[(sender as! UITableViewCell).tag]!.getWords()
            wordListController.menuEnabled = false
        } else {
            let wordController = segue.destinationViewController as! WordController
            wordController.word = Word.ids[(sender as! UITableViewCell).tag]
        }
    }
}
