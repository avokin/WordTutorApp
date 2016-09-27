//
// Created by Andrey Vokin on 10/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

class WordController: UIViewController {
    var word: Word? = nil
    @IBOutlet weak var lblTitle: UINavigationItem!

    @IBOutlet weak var lblTranslations: UILabel!
    @IBOutlet weak var lblComment: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.word!.translations.count > 0 {
            self.lblTranslations.text = self.word!.translations[0].text
        }

        self.lblComment.text = self.word!.comment
        self.lblTitle.title = self.word!.text
    }
}
