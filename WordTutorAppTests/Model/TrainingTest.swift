//
// Created by Andrey Vokin on 08/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import UIKit
import XCTest
import WordTutorApp

class TrainingTest: XCTestCase {
    func testGetWords() {
        let trainings = DataProvider.getInstance().getTrainings()
        let first = trainings[0]
        
        let count = first.getGroupsCount()
        XCTAssertEqual(1, count)
        
        let firstGroup = first.getGroup(0)
        XCTAssertEqual(4, firstGroup.count)
        XCTAssertEqual(1, firstGroup[0].getId())
        XCTAssertEqual(17, firstGroup[1].getId())
        XCTAssertEqual(19, firstGroup[2].getId())
        XCTAssertEqual(21, firstGroup[3].getId())
    }
}
