//
// Created by Andrey Vokin on 11/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

open class WordCategory {
    open static func create(_ wordId: Int, categoryId: Int) {
        let word = Word.ids[wordId]!
        let category = Category.ids[categoryId]!

        category.words.append(word)
        word.categories.append(category)
    }
}
