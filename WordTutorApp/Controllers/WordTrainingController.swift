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

    var failClicked = false
    var okClicked = false

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
        failClicked = false
        okClicked = false
    }

    @IBAction func rememberAction(_ sender: AnyObject) {
        if failClicked || okClicked {
            goToNext(success: !failClicked)
        } else {
            okClicked = true
            openCard()
        }
    }

    @IBAction func failAction(_ sender: AnyObject) {
        if failClicked || okClicked {
            goToNext(success: false)
        } else {
            failClicked = true
            openCard()
        }
    }

    public func handleTap() {
        if failClicked || okClicked {
            goToNext(success: !failClicked)
        } else {
            failClicked = true
            openCard()
        }
    }

    private func goToNext(success: Bool) {
        var newSuccessCount: Int
        if success {
            newSuccessCount = word!.getSuccessCount() + 1
        } else {
            newSuccessCount = 0
        }
        word!.setSuccessCount(value: newSuccessCount)
        (parent as! TrainingController).showNextController()
    }

    private func openCard() {
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
    }
}
