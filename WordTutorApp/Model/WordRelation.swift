//
//  WordRelation.swift
//  WordTutorApp
//
//  Created by Andrey Vokin on 10/04/16.
//  Copyright © 2016 avokin. All rights reserved.
//

import Foundation

open class WordRelation {
    var sourceWordId: Int
    var relatedWordId: Int
    var relationType: Int

    init(sourceWordId: Int, relatedWordId: Int, relationType: Int) {
        self.sourceWordId = sourceWordId
        self.relatedWordId = relatedWordId
        self.relationType = relationType
    }
}
