//
// Created by Andrey Vokin on 10/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

class WordController: UITableViewController {
    var word: Word? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.title = word!.text
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return word!.translations.count
        } else if section == 1 {
            return word!.synonyms.count
        } else {
            if word!.comment.characters.count > 0 {
                return 1
            }
            return 0
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override internal func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Translations"
        }
        if section == 1 {
            return "Related words"
        }
        return "Comment"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Word", forIndexPath: indexPath)

        if indexPath.section == 0 {
            cell.textLabel!.text = word!.translations[indexPath.row].text
        } else if indexPath.section == 1 {
            cell.textLabel!.text = word!.synonyms[indexPath.row].text
        } else {
            cell.textLabel!.text = word!.comment
        }

        return cell
    }
}
