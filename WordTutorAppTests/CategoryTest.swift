//
// Created by Andrey Vokin on 11/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import UIKit
import XCTest
import WordTutorApp

public class CategoryTest: XCTestCase {
    func testGetWords() {
        let categories = DataProvider.getInstance().getCategories()
        let first = categories[0]
        let words = first.getWords()

        XCTAssertEqual(4, words.count)
        if !words.contains({ $0.getText() == "Zapfel" }) ||
                !words.contains({ $0.getText() == "Shrank" }) ||
                !words.contains({ $0.getText() == "Kleidung" }) ||
                !words.contains({ $0.getText() == "Hemd" }) {
            XCTFail("Missing word")
        }
    }
}
    