//
// Created by Andrey Vokin on 02/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class ReplaceSegue: UIStoryboardSegue {
    override func perform() {
        let navigationController = sourceViewController.navigationController
        navigationController!.popViewControllerAnimated(false)
        navigationController!.pushViewController(destinationViewController, animated: true)
    }
}