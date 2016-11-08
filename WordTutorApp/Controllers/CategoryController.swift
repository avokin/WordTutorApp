//
// Created by Andrey Vokin on 09/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class CategoryController: WordListController {
    var category: Category? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = category!.name
    }

    override func getWords() -> [Word] {
        return category!.getWords();
    }
}
