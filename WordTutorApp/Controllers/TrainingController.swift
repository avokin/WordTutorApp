//
// Created by Andrey Vokin on 13/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class TrainingController: UIViewController {
    var training: Training?
    var groupNumber = 0
    var words = [Word]()
    var currentIndex = 0

    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var lblTranslations: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.words = training!.getGroup(groupNumber)
        initTest()
    }

    func initTest() {
        if currentIndex >= self.words.count {
            self.navigationController!.popViewControllerAnimated(true)
            return
        }

        lblWord.text = words[currentIndex].text
        lblTranslations.text = ""
    }

    @IBAction func rememberAction(sender: AnyObject) {
        currentIndex += 1
        initTest()
    }
    
    @IBAction func forgotAction(sender: AnyObject) {
        if lblTranslations.text == "" {
            lblTranslations.text = words[currentIndex].getTranslations()
        } else {
            currentIndex += 1
            initTest()
        }
    }
}
