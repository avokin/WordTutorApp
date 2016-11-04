//
// Created by Andrey Vokin on 09/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class TrainingPreview: WordListController {
    var training: Training?
    var groupIndex = 0

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func getWords() -> [Word] {
        return training!.getGroup(groupIndex);
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingWord", for: indexPath) as! TrainingWordCell

        let word: Word = words[(indexPath as NSIndexPath).row]
        cell.leftLabel.text = word.text
        cell.rightLabel.isHidden = word.timeToCheck > Date()

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
        }
    }
}
