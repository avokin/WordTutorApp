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

    @available(iOS 5.0, *) override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.destinationViewController is CategoryController {
            let wordListController = segue.destinationViewController as! CategoryController
            wordListController.category = sender as! Category
        }

        if segue.destinationViewController is TrainingController {
            let trainingController = segue.destinationViewController as! TrainingController
            trainingController.training = training
            trainingController.groupNumber = groupIndex
        }
    }
}
