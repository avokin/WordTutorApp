//
// Created by Andrey Vokin on 07/09/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class LoginHelper {
    var authorisationToken: String = ""
    static var instance: LoginHelper? = nil

    public static func getInstance() -> LoginHelper {
        if instance == nil {
            instance = LoginHelper()
        }
        return instance!
    }

}
