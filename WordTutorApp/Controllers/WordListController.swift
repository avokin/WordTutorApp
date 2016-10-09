//
//  WordListController.swift
//  WordTutorApp
//
//  Created by Andrey Vokin on 22/02/16
//  Copyright (c) 2015 avokin. All rights reserved.
//

import UIKit

class WordListController: UITableViewController {
    var words = [Word]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Word")
        words = self.getWords()
    }

    func getWords() -> [Word] {
        return [Word]();
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
        self.performSegueWithIdentifier("Word", sender: word)
    }

    @available(iOS 5.0, *) override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let wordController = segue.destinationViewController as! WordController
        wordController.word = (sender as! Word)
    }
}
