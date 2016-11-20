//
// Created by Andrey Vokin on 26/10/2016.
// Copyright (c) 2016 avokin. All rights reserved.
//

import UIKit
import XCTest
import WordTutorApp

public class WordTest : XCTestCase {
    func testGetWords() {
        let words = DataProvider.getInstance().getWords()

        let word = Word.findByText(text: words[2].getText())
        XCTAssertNotNil(word)
        XCTAssertEqual(words[2].getId(), word!.getId())
    }
}
