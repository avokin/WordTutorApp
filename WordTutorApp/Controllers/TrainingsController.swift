//
// Created by Andrey Vokin on 08/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class TrainingsController: UITableViewController {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!

    var trainings = DataProvider.getInstance().getTrainings()

    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))

        revealViewController().rightViewRevealWidth = 150
        extraButton.target = revealViewController()
        extraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))

        DataProvider.getInstance().serviceResponse = serviceResponseCallback
    }

    override internal func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let training = trainings[section]
        return trainings[section].category.name + " (" + String(training.category.getWords().count) + ")"
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.trainings.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trainings[section].getGroupsCount()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let training = trainings[indexPath.section]
        let cell = tableView.dequeueReusableCellWithIdentifier("WordGroup", forIndexPath: indexPath)
        cell.textLabel!.text = "  " + training.category.name + " #" + String(indexPath.row + 1)
        return cell
    }

    func serviceResponseCallback() {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.trainings = DataProvider.getInstance().getTrainings()
            self.tableView.reloadData()
        }
    }
}
