//
//  Word.swift
//  WordTutorApp
//
//  Created by Andrey Vokin on 10/04/16.
//  Copyright © 2016 avokin. All rights reserved.
//

import Foundation

open class Word {
    open var id: Int = 0
    var text: String = ""
    var comment: String = ""
    var typeId: Int = 1
    var customIntField1: Int = 0
    var customStringField1: String = ""
    var languageId: Int = 0
    var timeToCheck = Date()

    var language: Language?

    var translations: [Word] = []
    var synonyms: [Word] = []
    var categories: [Category] = []

    open static var ids: [Int: Word] = [Int: Word]()

    convenience init(json: String) throws {
        let jsonData = json.data(using: String.Encoding.utf8, allowLossyConversion: false)
        let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData!, options: []) as! NSDictionary
        self.init(dictionary: jsonDictionary)
    }

    init(dictionary: NSDictionary) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        for (key, value) in dictionary {
            let keyName = key as! String
            if value is NSNull {
                continue
            }

            if "id" == keyName {
                self.id = (value as! NSNumber).intValue
            } else if "language_id" == keyName {
                self.languageId = (value as! NSNumber).intValue
            } else if "text" == keyName {
                self.text = value as! String
            } else if "comment" == keyName {
                self.comment = value as! String
            } else if "type_id" == keyName {
                self.typeId = (value as! NSNumber).intValue
            } else if "custom_int_field1" == keyName {
                self.customIntField1 = (value as! NSNumber).intValue
            } else if "custom_string_field1" == keyName {
                self.customStringField1 = value as! String
            } else if "time_to_check" == keyName {
                let string = value as! String
                self.timeToCheck = dateFormatter.date(from: string)!
            }
        }
        Word.ids[self.id] = self
    }

    convenience init(id: Int, text: String) {
        self.init(id: id, text: text, translation: nil)
    }

    init(id: Int, text: String, translation: Word?) {
        self.id = id
        self.text = text
        self.synonyms = [Word]()

        self.typeId = 1
        self.comment = "comment"
        self.customIntField1 = 1
        self.customStringField1 = "plural"
        if translation != nil {
            self.translations = [translation!]
        } else {
            self.translations = [Word]()
        }
        Word.ids[self.id] = self
    }

    open func getText() -> String {
        return self.text
    }

    open func getId() -> Int {
        return self.id
    }

    open func getLanguageId() -> Int {
        return self.languageId
    }

    open func getTypeId() -> Int {
        return self.typeId
    }

    open func getComment() -> String {
        return self.comment
    }

    open func getCustomIntField1() -> Int {
        return self.customIntField1
    }

    open func getCustomStringField1() -> String {
        return self.customStringField1
    }

    open func getTranslations() -> String {
        return translations.map{$0.text}.joined(separator: "\n")
    }
}
