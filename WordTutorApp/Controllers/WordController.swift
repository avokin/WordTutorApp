//
// Created by Andrey Vokin on 10/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

class WordController: UIViewController {
    var word: Word? = nil
    @IBOutlet weak var lblTitle: UINavigationItem!

    @IBOutlet weak var lblTranslations: UILabel!
    @IBOutlet weak var lblSynonyms: UILabel!
    @IBOutlet weak var lblComment: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        var translations = ""
        for translation in self.word!.translations {
            translations += translation.getText() + "\n"
        }
        translations = translations.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        self.lblTranslations.text = translations

        var synonyms = ""
        for synonym in self.word!.synonyms {
            synonyms += synonym.getText() + "\n"
        }
        synonyms = synonyms.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        self.lblSynonyms.text = synonyms


        self.lblComment.text = self.word!.comment
        self.lblTitle.title = self.word!.text
    }
}
