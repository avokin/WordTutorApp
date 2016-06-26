//
// Created by Andrey Vokin on 26/06/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

public class JsonParser {
    public static func parseWord(text: String) -> Word? {
        do {
            let word = try Word(json: text)
            return word
        } catch {
            print("Ok")
        }
        return nil
    }
}
