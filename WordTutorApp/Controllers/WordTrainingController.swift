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

    @IBAction func rememberAction(_ sender: AnyObject) {
        initTest()
    }
    
    @IBAction func forgotAction(_ sender: AnyObject) {
        lblTranslations.text = word!.getTranslations()

        let now = Date()
        let calendar = Calendar.current
        word!.timeToCheck = calendar.date(byAdding: .day, value: 1, to: now)!
        word!.successCount = 0
    }
}
