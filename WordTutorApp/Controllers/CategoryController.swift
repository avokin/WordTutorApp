//
// Created by Andrey Vokin on 09/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class CategoryController: WordListController {
    var category: Category? = nil
    var words = [Word]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category!.name
        words = category!.getWords()
    }

    override func getWords() -> [Word] {
        return words;
    }
}
