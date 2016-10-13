//
//  Word.swift
//  WordTutorApp
//
//  Created by Andrey Vokin on 10/04/16.
//  Copyright © 2016 avokin. All rights reserved.
//

import Foundation

public class Word {
    public var id: Int = 0
    var text: String = ""
    var comment: String = ""
    var typeId: Int = 1
    var customIntField1: Int = 0
    var customStringField1: String = ""
    var languageId: Int = 0
    var timeToCheck = NSDate()

    var language: Language?

    var translations: [Word] = []
    var synonyms: [Word] = []
    var categories: [Category] = []

    public static var ids: [Int: Word] = [Int: Word]()

    convenience init(json: String) throws {
        let jsonData = json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: []) as! NSDictionary
        self.init(dictionary: jsonDictionary)
    }

    init(dictionary: NSDictionary) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        for (key, value) in dictionary {
            let keyName = key as! String
            if value is NSNull {
                continue
            }

            if "id" == keyName {
                self.id = (value as! NSNumber).integerValue
            } else if "language_id" == keyName {
                self.languageId = (value as! NSNumber).integerValue
            } else if "text" == keyName {
                self.text = value as! String
            } else if "comment" == keyName {
                self.comment = value as! String
            } else if "type_id" == keyName {
                self.typeId = (value as! NSNumber).integerValue
            } else if "custom_int_field1" == keyName {
                self.customIntField1 = (value as! NSNumber).integerValue
            } else if "custom_string_field1" == keyName {
                self.customStringField1 = value as! String
            } else if "time_to_check" == keyName {
                let string = value as! String
                self.timeToCheck = dateFormatter.dateFromString(string)!
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

    public func getText() -> String {
        return self.text
    }

    public func getId() -> Int {
        return self.id
    }

    public func getLanguageId() -> Int {
        return self.languageId
    }

    public func getTypeId() -> Int {
        return self.typeId
    }

    public func getComment() -> String {
        return self.comment
    }

    public func getCustomIntField1() -> Int {
        return self.customIntField1
    }

    public func getCustomStringField1() -> String {
        return self.customStringField1
    }

    public func getTranslations() -> String {
        return translations.map{$0.text}.joinWithSeparator("\n")
    }
}
