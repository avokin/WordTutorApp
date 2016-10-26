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

    override internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let training = trainings[section]
        return trainings[section].category.name + " (" + String(training.category.getWords().count) + ")"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.trainings.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trainings[section].getGroupsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let training = trainings[(indexPath as NSIndexPath).section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordGroup", for: indexPath)
        cell.textLabel!.text = "  " + training.category.name + " #" + String((indexPath as NSIndexPath).row + 1)
        return cell
    }

    func serviceResponseCallback() {
        OperationQueue.main.addOperation {
            self.trainings = DataProvider.getInstance().getTrainings()
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "TrainingWordGroup", sender: indexPath)
    }

    @available(iOS 5.0, *) override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! IndexPath
        let training = trainings[(indexPath as NSIndexPath).section]
        let trainingWordGroupController = segue.destination as! TrainingPreview

        trainingWordGroupController.training = training
        trainingWordGroupController.groupIndex = (indexPath as NSIndexPath).row
    }
}