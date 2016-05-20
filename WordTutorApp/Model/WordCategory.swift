//
// Created by Andrey Vokin on 11/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

public class WordCategory {
    var wordId: Int
    var categoryId: Int

    var word: Word? = nil

    init(wordId: Int, categoryId: Int) {
        self.wordId = wordId
        self.categoryId = categoryId
    }

    func getWord() -> Word {
        if word == nil {
            for w in DataProvider.getInstance().getWords() {
                if w.id == wordId {
                    word = w
                    break
                }
            }
        }
        return word!
    }
}
