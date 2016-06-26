//
// Created by Andrey Vokin on 26/06/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import UIKit
import XCTest
import WordTutorApp

class JsonParserTest: XCTestCase {
    func testParsing() {
        let word = JsonParser.parseWord("{\"id\": 200, \"text\": \"test\", \"comment\": \"myComment\", \"typeId\": 2, \"customIntField1\": 2, \"customStringField1\": \"myCustomStringField1\"}")!

        XCTAssertEqual(200, word.getId())
        XCTAssertEqual("test", word.getText())
        XCTAssertEqual("myComment", word.getComment())
        XCTAssertEqual(2, word.getTypeId())
        XCTAssertEqual(2, word.getCustomIntField1())
        XCTAssertEqual("myCustomStringField1", word.getCustomStringField1())
    }
}
