//
// Created by Andrey Vokin on 24/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

class GermanNounController: WordController {
    @IBOutlet weak var lblPlural: UILabel!
    @IBOutlet weak var lblGeder: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        lblGeder.text = GermanUtil.getGenderPresentation(word!.customIntField1)
        lblPlural.text = word!.customStringField1
    }
}
