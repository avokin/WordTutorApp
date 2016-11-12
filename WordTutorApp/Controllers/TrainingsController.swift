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

        DataProvider.getInstance().serviceResponse = serviceResponseCallback

        tableView.register(UINib(nibName: "TrainingTableViewCell", bundle: nil), forCellReuseIdentifier: "TrainingTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
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
        let groupNumber = (indexPath as NSIndexPath).row
        let group = training.getGroup(groupNumber)

        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingTableViewCell", for: indexPath) as! TrainingTableViewCell
        cell.lblTitle!.text = "  " + training.category.name + " #" + String(groupNumber + 1)

        cell.icon.isHidden = true
        for word in group {
            if word.getTimeToCheck() < Date() {
                cell.icon.isHidden = false
                break;
            }
        }

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
        let index = (indexPath as NSIndexPath).row
        let training = trainings[(indexPath as NSIndexPath).section]
        let trainingWordGroupController = segue.destination as! TrainingPreviewController

        trainingWordGroupController.title = training.category.name + " #\(index + 1)"
        trainingWordGroupController.training = training
        trainingWordGroupController.groupIndex = index
    }
}
