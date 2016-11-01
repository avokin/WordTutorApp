//
// Created by Andrey Vokin on 26/10/2016.
// Copyright (c) 2016 avokin. All rights reserved.
//

import UIKit
import XCTest
import WordTutorApp

class WordTest : XCTestCase {
    func testSerialize() {
        let words = DataProvider.getInstance().getWords()
        let first = words[0]

        let json = first.serialize()
        XCTAssertEqual("", json)
    }
}