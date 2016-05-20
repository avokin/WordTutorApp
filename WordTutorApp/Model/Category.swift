//
// Created by Andrey Vokin on 11/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

public class Category {
    var id: Int
    var text: String

    var words: [Word]? = nil

    init(id: Int, text: String) {
        self.id = id
        self.text = text
    }

    public func getWords() -> [Word] {
        if words == nil {
            var wordIds = [Int]()
            let allWordsCategories = DataProvider.getInstance().getWordsCategories()
            for wordCategory in allWordsCategories {
                if wordCategory.categoryId == self.id {
                    wordIds.append(wordCategory.wordId)
                }
            }

            words = [Word]()
            let allWords = DataProvider.getInstance().getWords()
            for word in allWords {
                if wordIds.contains(word.id) {
                    words!.append(word)
                }
            }
        }
        return words!
    }
}