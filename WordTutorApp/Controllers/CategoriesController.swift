//
//  CategoriesController.swift
//  WordTutorApp
//
//  Created by Andrey Vokin on 22/02/16
//  Copyright (c) 2015 avokin. All rights reserved.
//

import UIKit

class CategoriesController: UITableViewController {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!

    var modelProvider = DataProvider.getInstance()

    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
        }

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Category")
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelProvider.getCategories().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Category", forIndexPath: indexPath)

        let category = modelProvider.getCategories()[indexPath.row]
        cell.textLabel!.text = category.name

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let category = modelProvider.getCategories()[indexPath.row]
        self.performSegueWithIdentifier("Category", sender: category)
    }

    @available(iOS 5.0, *) override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let wordListController = segue.destinationViewController as! WordListController
        wordListController.words = (sender as! Category).getWords()
        wordListController.menuEnabled = false
    }
}
