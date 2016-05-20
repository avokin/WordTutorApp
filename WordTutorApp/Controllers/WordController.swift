//
// Created by Andrey Vokin on 10/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

class WordController: UIViewController {
    var word: Word? = nil
    @IBOutlet public weak var lblTitle: UINavigationItem!

    @IBOutlet public weak var lblTranslations: UILabel!
    @IBOutlet public weak var lblComment: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblTranslations.text = self.word!.translations[0].text
        self.lblComment.text = self.word!.comment
        self.lblTitle.title = self.word!.text
    }
}
