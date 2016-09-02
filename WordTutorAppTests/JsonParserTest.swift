//
// Created by Andrey Vokin on 26/06/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import UIKit
import XCTest
import WordTutorApp

class JsonParserTest: XCTestCase {
    func testParsing() {
        let word = JsonParser.parseWord("{\"id\": 200, \"language_id\": 1, \"text\": \"test\", \"comment\": \"myComment\", \"type_id\": 2, \"custom_int_field1\": 2, \"custom_string_field1\": \"myCustomStringField1\"}")!

        XCTAssertEqual(200, word.getId())
        XCTAssertEqual(1, word.getLanguageId())
        XCTAssertEqual("test", word.getText())
        XCTAssertEqual("myComment", word.getComment())
        XCTAssertEqual(2, word.getTypeId())
        XCTAssertEqual(2, word.getCustomIntField1())
        XCTAssertEqual("myCustomStringField1", word.getCustomStringField1())
    }

    func testParsingApi() {
        let word = JsonParser.parseWord("{\"id\":16,\"language_id\":3,\"text\":\"компьютер\",\"comment\":null,\"type_id\":null,\"custom_int_field1\":null,\"custom_string_field1\":null}")!

        XCTAssertEqual(16, word.getId())
        XCTAssertEqual(3, word.getLanguageId())
        XCTAssertEqual("компьютер", word.getText())
        XCTAssertEqual("", word.getComment())
        XCTAssertEqual(1, word.getTypeId())
        XCTAssertEqual(0, word.getCustomIntField1())
        XCTAssertEqual("", word.getCustomStringField1())
    }
}
