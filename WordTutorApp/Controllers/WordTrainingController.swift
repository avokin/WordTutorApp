//
// Created by Andrey Vokin on 13/10/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class WordTrainingController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var lblTranslations: UILabel!
    @IBOutlet weak var lblGrammar: UILabel!
    @IBOutlet weak var lblComment: UILabel!

    var word: Word?

    var wordIndex = 0
    var leftSibling: WordTrainingController?
    var rightSibling: WordTrainingController?

    var isFailed = false

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap"))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        initTest()
    }

    func initTest() {
        (parent as! TrainingController).currentIndex = wordIndex
        lblWord.text = word!.text
        lblGrammar.text = ""
        lblTranslations.text = ""
        lblComment.text = ""
        isFailed = false
    }

    @IBAction func rememberAction(_ sender: AnyObject) {
        word!.setSuccessCount(value: word!.getSuccessCount() + 1)
        (parent as! TrainingController).showNextController()
    }

    public func handleTap() {
        if !isFailed {
            isFailed = true

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

            word!.setSuccessCount(value: 0)
        } else {
            (parent as! TrainingController).showNextController()
        }
    }
}
