//
//  Word.swift
//  WordTutorApp
//
//  Created by Andrey Vokin on 10/04/16.
//  Copyright © 2016 avokin. All rights reserved.
//

import Foundation

open class Word {
    static let intervals = [6, 24, 3 * 24, 7 * 24, 30 * 24, 3 * 30 * 24]
    var dictionary: NSMutableDictionary = NSMutableDictionary()

    var id: Int = 0
    var text: String = ""
    var comment: String = ""
    var typeId: Int = 1
    var customIntField1: Int = 0
    var customStringField1: String = ""
    var languageId: Int = 0
    var successCount: Int = 0
    var timeToCheck = Date()

    var language: Language?

    var translations: [Word] = []
    var synonyms: [Word] = []
    var categories: [Category] = []

    var _isUpdated = false

    open static var ids: [Int: Word] = [Int: Word]()

    init(dictionary: NSMutableDictionary) {
        self.dictionary = dictionary
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
                self.timeToCheck = JsonParser.getDateFormatter().date(from: string)!
            } else if "success_count" == keyName {
                self.successCount = (value as! NSNumber).intValue
            } else if "is_updated" == keyName {
                self._isUpdated = (value as! String) == "true"
            }
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

    open func setSuccessCount(value: Int) {
        successCount = value
        dictionary["success_count"] = NSNumber(value: value)

        let index = max(0, min(successCount, Word.intervals.count) - 1)
        let newTimeToCheck = Calendar.current.date(byAdding: .hour, value: Word.intervals[index], to: Date())!

        setTimeToCheck(value: newTimeToCheck)
    }

    open func setTimeToCheck(value: Date) {
        timeToCheck = value
        dictionary["time_to_check"] = JsonParser.getDateFormatter().string(from: value)
        dictionary["is_updated"] = "true"
        _isUpdated = true
    }

    public func setUpdated(value: Bool) {
        if value {
            dictionary["is_updated"] = "true"
        } else {
            dictionary["is_updated"] = "false"
        }
        _isUpdated = value
    }

    public func getSuccessCount() -> Int {
        return successCount
    }

    public func getTimeToCheck() -> Date {
        return timeToCheck
    }

    public func isUpdated() -> Bool {
        return _isUpdated
    }
}
