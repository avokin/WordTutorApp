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

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Word")
        words = self.getWords()
    }

    func getWords() -> [Word] {
        return [Word]();
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)

        let word: Word = words[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = word.text

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word: Word = words[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "Word", sender: word)
    }

    @available(iOS 5.0, *) override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is WordController {
            let wordController = segue.destination as! WordController
            wordController.word = (sender as! Word)
        }
    }
}
