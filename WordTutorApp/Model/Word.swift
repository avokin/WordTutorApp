//
//  Word.swift
//  WordTutorApp
//
//  Created by Andrey Vokin on 10/04/16.
//  Copyright © 2016 avokin. All rights reserved.
//

import Foundation

public class Word {
    var id: Int
    var text: String
    var comment: String
    var typeId: Int
    var customIntField1: Int
    var customStringField1: String

    var translations: [Word]
    var synonims: [Word]

    convenience init(id: Int, text: String) {
        self.init(id: id, text: text, translation: nil)
    }

    init(id: Int, text: String, translation: Word?) {
        self.id = id
        self.text = text
        self.synonims = [Word]()

        self.typeId = 1
        self.comment = "comment"
        self.customIntField1 = 1
        self.customStringField1 = "plural"
        if translation != nil {
            self.translations = [translation!]
        } else {
            self.translations = [Word]()
        }
    }

    public func getText() -> String {
        return self.text
    }
}
