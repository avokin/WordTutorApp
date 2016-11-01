//
// Created by Andrey Vokin on 26/06/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

open class JsonParser {
    open static func parseWord(_ text: String) -> Word? {
        do {
            let word = try Word(json: text)
            return word
        } catch {
            print(error)
        }
        return nil
    }

    open static func serialize(objects: [Serializable], arrayName: String) -> String {
        let serialized = objects.map{$0.serialize()}
        let arrayContent = serialized.joined(separator: ",")
        return "\"\(arrayName)\": [\(arrayContent)]"
    }
}
