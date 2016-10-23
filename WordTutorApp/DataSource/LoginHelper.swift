//
// Created by Andrey Vokin on 07/09/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

open class LoginHelper {
    fileprivate static let AUTHORIZATION_TOKEN = "AuthorizationToken"
    fileprivate static var instance: LoginHelper? = nil

    open static func getInstance() -> LoginHelper {
        if instance == nil {
            instance = LoginHelper()
        }
        return instance!
    }

    open func getAuthorizationToken() -> String? {
        return UserDefaults.standard.string(forKey: LoginHelper.AUTHORIZATION_TOKEN)
    }

    open func setAuthorizationToken(_ token: String?) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: LoginHelper.AUTHORIZATION_TOKEN)
    }
}
