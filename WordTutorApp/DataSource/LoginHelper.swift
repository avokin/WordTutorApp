//
// Created by Andrey Vokin on 07/09/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

public class LoginHelper {
    private static let AUTHORIZATION_TOKEN = "AuthorizationToken"
    private static var instance: LoginHelper? = nil

    public static func getInstance() -> LoginHelper {
        if instance == nil {
            instance = LoginHelper()
        }
        return instance!
    }

    public func getAuthorizationToken() -> String? {
        return NSUserDefaults.standardUserDefaults().stringForKey(LoginHelper.AUTHORIZATION_TOKEN)
    }

    public func setAuthorizationToken(token: String?) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(token, forKey: LoginHelper.AUTHORIZATION_TOKEN)
    }
}
