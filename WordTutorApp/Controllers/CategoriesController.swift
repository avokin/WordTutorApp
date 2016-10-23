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
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Category")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelProvider.getCategories().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)

        let category = modelProvider.getCategories()[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = category.name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = modelProvider.getCategories()[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "Category", sender: category)
    }

    @available(iOS 5.0, *) override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let wordListController = segue.destination as! CategoryController
        wordListController.category = sender as! Category
    }
}
