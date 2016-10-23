//
// Created by Andrey Vokin on 11/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

open class Category {
    var id: Int
    var name: String

    open var words: [Word] = [Word]()

    open static var ids: [Int: Category] = [Int: Category]()

    init(id: Int, name: String) {
        self.id = id
        self.name = name

        Category.ids[self.id] = self
    }

    convenience init(dictionary: NSDictionary) {
        let id = (dictionary["id"] as! NSNumber).intValue
        self.init(id: id, name: dictionary["name"] as! String)
    }

    open func getWords() -> [Word] {
        return words
    }
}
