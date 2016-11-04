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
    @IBOutlet weak var lblGrammar: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        initTest()
    }

    func initTest() {
        lblWord.text = word!.text
        lblGrammar.text = ""
        lblTranslations.text = ""
        lblComment.text = ""
    }

    @IBAction func rememberAction(_ sender: AnyObject) {
        initTest()
    }
    
    @IBAction func forgotAction(_ sender: AnyObject) {
        lblGrammar.text = word!.getCustomStringField1()
        lblTranslations.text = word!.getTranslations()
        lblComment.text = word!.getComment()

        let now = Date()
        let calendar = Calendar.current
        word!.timeToCheck = calendar.date(byAdding: .day, value: 1, to: now)!
        word!.successCount = 0
    }
}
