//
// Created by Andrey Vokin on 24/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

public class GermanUtil {
    public static func getWordTypePresentation(typeId: Int) -> String {
        if typeId == 1 {
            return "Noun"
        } else if typeId == 2 {
            return "Verb"
        }
        return "Unknown"
    }

    public static func getGenderPresentation(genderId: Int) -> String {
        if genderId == 1 {
            return "Maskulin"
        } else if genderId == 2 {
            return "Neutrum"
        } else if genderId == 3 {
            return "Feminium"
        } else if genderId == 4 {
            return "Plural"
        }
        return "Unknown"
    }
}
