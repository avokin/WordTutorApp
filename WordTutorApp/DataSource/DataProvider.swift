//
// Created by Andrey Vokin on 10/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

public class DataProvider {
    var words: [Word]? = nil
    var categories: [Category]? = nil
    var wordsCategories: [WordCategory]? = nil

    static var instance: DataProvider? = nil

    public static func getInstance() -> DataProvider {
        if instance == nil {
            instance = DataProvider()
        }
        return instance!
    }

    public func getWords() -> [Word] {
        if words == nil {
            words = [Word]()

            words!.append(Word(id: 1, text: "Zapfel", translation: Word(id: 2, text: "шишка")))
            words!.append(Word(id: 3, text: "Hund", translation: Word(id: 4, text: "собака")))
            words!.append(Word(id: 5, text: "Fenster", translation: Word(id: 6, text: "ккно")))
            words!.append(Word(id: 7, text: "Kind", translation: Word(id: 8, text: "ребенок")))
            words!.append(Word(id: 9, text: "Lampe", translation: Word(id: 10, text: "лампа")))
            words!.append(Word(id: 11, text: "Zug", translation: Word(id: 12, text: "поезд")))
            words!.append(Word(id: 13, text: "not", translation: Word(id: 14, text: "экстренный")))
            words!.append(Word(id: 15, text: "Wohnung", translation: Word(id: 16, text: "квартира")))
            words!.append(Word(id: 17, text: "Shrank", translation: Word(id: 18, text: "шкаф")))
            words!.append(Word(id: 19, text: "Kleidung", translation: Word(id: 20, text: "одежда")))
            words!.append(Word(id: 21, text: "Hemd", translation: Word(id: 22, text: "рубашка")))
            words!.append(Word(id: 23, text: "Baum", translation: Word(id: 24, text: "дерево")))
            words!.append(Word(id: 25, text: "Katz", translation: Word(id: 26, text: "кот")))
            words!.append(Word(id: 27, text: "Küh", translation: Word(id: 28, text: "корова")))
        }

        return words!
    }

    public func getCategories() -> [Category] {
        if categories == nil {
            categories = [Category]()

            categories!.append(Category(id: 1, text: "Haus"))
            categories!.append(Category(id: 2, text: "Tiere"))
            categories!.append(Category(id: 3, text: "Herb"))
        }

        return categories!
    }

    public func getWordsCategories() -> [WordCategory] {
        if wordsCategories == nil {
            wordsCategories = [WordCategory]()

            wordsCategories!.append(WordCategory(wordId: 1, categoryId: 1))
            wordsCategories!.append(WordCategory(wordId: 17, categoryId: 1))
            wordsCategories!.append(WordCategory(wordId: 19, categoryId: 1))
            wordsCategories!.append(WordCategory(wordId: 21, categoryId: 1))

            wordsCategories!.append(WordCategory(wordId: 3, categoryId: 2))
            wordsCategories!.append(WordCategory(wordId: 25, categoryId: 2))

            wordsCategories!.append(WordCategory(wordId: 1, categoryId: 3))
            wordsCategories!.append(WordCategory(wordId: 23, categoryId: 3))
        }

        return wordsCategories!
    }

}
