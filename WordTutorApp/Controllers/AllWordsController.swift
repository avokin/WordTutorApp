//
// Created by Andrey Vokin on 09/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class AllWordsController: WordListController, UISearchResultsUpdating {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!

    var words = DataProvider.getInstance().getWordsOfDestinationLanguage()
    var filteredWords = [Word]()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false

        tableView.tableHeaderView = searchController.searchBar

        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))

        DataProvider.getInstance().serviceResponse = serviceResponseCallback
    }

    override func getWords() -> [Word] {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredWords
        }
        return words;
    }

    func serviceResponseCallback() {
        OperationQueue.main.addOperation {
            self.words = DataProvider.getInstance().getWordsOfDestinationLanguage()
            self.tableView.reloadData()
        }
    }

    func filterContentForSearchText(searchText: String) {
        filteredWords = DataProvider.getInstance().getWordsOfDestinationLanguage().filter({( word : Word) -> Bool in
            return word.text.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
