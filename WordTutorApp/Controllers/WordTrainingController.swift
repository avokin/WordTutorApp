//
// Created by Andrey Vokin on 13/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class WordTrainingController: UIViewController {
    var word: Word?

    var wordIndex = 0
    var leftSibling: WordTrainingController?
    var rightSibling: WordTrainingController?


    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var lblTranslations: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        initTest()
    }

    func initTest() {
        lblWord.text = word!.text
        lblTranslations.text = ""
    }

    @IBAction func rememberAction(sender: AnyObject) {
        initTest()
    }
    
    @IBAction func forgotAction(sender: AnyObject) {
        if lblTranslations.text == "" {
            lblTranslations.text = word!.getTranslations()
        } else {
            initTest()
        }
    }
}
