//
// Created by Andrey Vokin on 11/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

public class WordCategory {
    public static func create(wordId: Int, categoryId: Int) {
        let word = Word.ids[wordId]!
        let category = Category.ids[categoryId]!

        category.words.append(word)
        word.categories.append(category)
    }
}
