//
// Created by Andrey Vokin on 26/06/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

open class JsonParser {
    private static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    private static var dateFormatter: DateFormatter?

    public static func getDateFormatter() -> DateFormatter {
        if dateFormatter == nil {
            dateFormatter = DateFormatter()
            dateFormatter!.dateFormat = dateFormat
        }
        return dateFormatter!
    }
}
