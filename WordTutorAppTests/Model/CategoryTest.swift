//
// Created by Andrey Vokin on 11/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import UIKit
import XCTest
import WordTutorApp

open class CategoryTest: XCTestCase {
    func testGetWords() {
        let categories = DataProvider.getInstance().getCategories()
        let first = categories[0]
        let words = first.getWords()

        XCTAssertEqual(4, words.count)
        if !words.contains(where: { $0.getText() == "Zapfel" }) ||
                !words.contains(where: { $0.getText() == "Schrank" }) ||
                !words.contains(where: { $0.getText() == "Kleidung" }) ||
                !words.contains(where: { $0.getText() == "Hemd" }) {
            XCTFail("Missing word")
        }
    }
}
    
