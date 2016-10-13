//
// Created by Andrey Vokin on 09/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class TrainingWordGroupController: WordListController {
    var training: Training?
    var groupIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func getWords() -> [Word] {
        return training!.getGroup(groupIndex);
    }

    @available(iOS 5.0, *) override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.destinationViewController is CategoryController {
            let wordListController = segue.destinationViewController as! CategoryController
            wordListController.category = sender as! Category
        }
    }
}
