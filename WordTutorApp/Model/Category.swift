//
// Created by Andrey Vokin on 11/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

public class Category {
    var id: Int
    var name: String

    public var words: [Word] = [Word]()

    public static var ids: [Int: Category] = [Int: Category]()

    init(id: Int, name: String) {
        self.id = id
        self.name = name

        Category.ids[self.id] = self
    }

    convenience init(dictionary: NSDictionary) {
        let id = (dictionary["id"] as! NSNumber).integerValue
        self.init(id: id, name: dictionary["name"] as! String)
    }

    public func getWords() -> [Word] {
        return words
    }
}