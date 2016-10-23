//
// Created by Andrey Vokin on 09/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class TrainingPreview: WordListController {
    var training: Training?
    var groupIndex = 0

    override func getWords() -> [Word] {
        return training!.getGroup(groupIndex);
    }

    @available(iOS 5.0, *) override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.destination is CategoryController {
            let wordListController = segue.destination as! CategoryController
            wordListController.category = sender as! Category
        }

        if segue.destination is TrainingController {
            let trainingController = segue.destination as! TrainingController
            trainingController.training = training
            trainingController.groupNumber = groupIndex
        }
    }
}
