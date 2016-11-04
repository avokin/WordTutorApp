//
// Created by Andrey Vokin on 13/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class WordTrainingController: UIViewController {
    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var lblTranslations: UILabel!
    @IBOutlet weak var lblGrammar: UILabel!
    @IBOutlet weak var lblComment: UILabel!

    var word: Word?

    var wordIndex = 0
    var leftSibling: WordTrainingController?
    var rightSibling: WordTrainingController?

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
        (parent as! TrainingController).showNextController()
    }
    
    @IBAction func forgotAction(_ sender: AnyObject) {
        if word!.getTypeId() == 2 {
            var grammar = ""
            if word!.getCustomIntField1() == 1 {
                grammar = "Maskulin"
            } else if word!.getCustomIntField1() == 2 {
                grammar = "Neutrum"
            } else if word!.getCustomIntField1() == 3 {
                grammar = "Femininum"
            }
            if word!.getCustomStringField1().characters.count > 0 {
                grammar = grammar + " (" + word!.getCustomStringField1() + ")"
            }

            lblGrammar.text = grammar
        }
        lblTranslations.text = word!.getTranslations()
        lblComment.text = word!.getComment()

        let now = Date()
        let calendar = Calendar.current
        word!.timeToCheck = calendar.date(byAdding: .day, value: 1, to: now)!
        word!.successCount = 0
    }
}
