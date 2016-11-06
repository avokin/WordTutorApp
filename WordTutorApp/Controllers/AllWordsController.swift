//
// Created by Andrey Vokin on 09/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class AllWordsController: WordListController {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))

        DataProvider.getInstance().serviceResponse = serviceResponseCallback
    }

    override func getWords() -> [Word] {
        return DataProvider.getInstance().getWordsOfDestinationLanguage();
    }

    func serviceResponseCallback() {
        OperationQueue.main.addOperation {
            self.words = DataProvider.getInstance().getWordsOfDestinationLanguage()
            self.tableView.reloadData()
        }
    }
}
