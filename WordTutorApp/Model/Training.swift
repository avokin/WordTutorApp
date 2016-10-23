//
// Created by Andrey Vokin on 08/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

open class Training {
    let GROUP_SIZE = 20
    var category: Category

    init(category: Category) {
        self.category = category
    }

    open func getGroupsCount() -> Int {
        return (self.category.getWords().count - 1) / GROUP_SIZE + 1
    }

    open func getGroup(_ number: Int) -> [Word] {
        var words = self.category.getWords()
        words = words.sorted(by: sortFunc)

        let start = number * GROUP_SIZE
        let end = min((number + 1) * GROUP_SIZE, words.count) - 1
        return Array(words[start...end])
    }

    func sortFunc(_ word1: Word, word2: Word) -> Bool {
        return word1.id < word2.id
    }
}
