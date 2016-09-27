//
//  WordListController.swift
//  WordTutorApp
//
//  Created by Andrey Vokin on 22/02/16
//  Copyright (c) 2015 avokin. All rights reserved.
//

import UIKit

class WordListController: UITableViewController {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!

    var words = DataProvider.getInstance().getWords()
    var menuEnabled = true

    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil && menuEnabled {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"

            revealViewController().rightViewRevealWidth = 150
            extraButton.target = revealViewController()
            extraButton.action = "rightRevealToggle:"
        }

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Word")
        DataProvider.getInstance().serviceResponse = serviceResponseCallback
    }

    func serviceResponseCallback() {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.words = DataProvider.getInstance().getWordsOfDestinationLanguage()
            self.tableView.reloadData()
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Word", forIndexPath: indexPath)

        let word: Word = words[indexPath.row]
        cell.textLabel!.text = word.text

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let word: Word = words[indexPath.row]
        var segue = "Word"
        if word.typeId == 2 {
            segue = "GermanNoun"
        }
        self.performSegueWithIdentifier(segue, sender: word)
    }

    @available(iOS 5.0, *) override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let wordController = segue.destinationViewController as! WordController
        wordController.word = (sender as! Word)
    }
}
