//
// Created by Andrey Vokin on 09/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class TrainingPreviewController: WordListController {
    var training: Training?
    var groupIndex = 0
    var directMode = true

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "TrainingItemCell", bundle: nil), forCellReuseIdentifier: "TrainingItemCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func getWords() -> [Word] {
        return training!.getGroup(groupIndex);
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingItemCell", for: indexPath) as! TrainingCell

        let word: Word = words[(indexPath as NSIndexPath).row]
        cell.lblTitle.text = word.text
        cell.icon.isHidden = word.timeToCheck > Date()
        let progressValue: Float = Float(word.successCount) / Float(Word.intervals.count)
        cell.pbStatus.progress = progressValue

        return cell
    }

    @available(iOS 5.0, *) override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.destination is CategoryController {
            let wordListController = segue.destination as! CategoryController
            wordListController.category = sender as? Category
        }

        if segue.destination is TrainingController {
            let trainingController = segue.destination as! TrainingController
            trainingController.training = training
            trainingController.groupNumber = groupIndex
            trainingController.directMode = directMode
        }
    }

    @IBAction func startAction(_ sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil, message: "Choose training mode", preferredStyle: .actionSheet)

        let directAction = UIAlertAction(title: "Deutsch -> Russian", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.directMode = true
            self.performSegue(withIdentifier: "StartTraining", sender: sender)
        })
        let backwardAction = UIAlertAction(title: "Russian -> Deutsch", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.directMode = false
            self.performSegue(withIdentifier: "StartTraining", sender: sender)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })

        optionMenu.addAction(directAction)
        optionMenu.addAction(backwardAction)
        optionMenu.addAction(cancelAction)

        present(optionMenu, animated: true, completion: nil)
    }
}
