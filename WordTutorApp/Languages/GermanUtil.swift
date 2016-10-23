//
// Created by Andrey Vokin on 24/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

open class GermanUtil {
    open static func getWordTypePresentation(_ typeId: Int) -> String {
        if typeId == 1 {
            return "Noun"
        } else if typeId == 2 {
            return "Verb"
        }
        return "Unknown"
    }

    open static func getGenderPresentation(_ genderId: Int) -> String {
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
