//
// Created by Andrey Vokin on 10/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

public class DataProvider {
    public static let HOST = "http://word-tutor.herokuapp.com/"

    private static var instance: DataProvider? = nil

    public var serviceResponse: (() -> Void)? = nil

    var words: [Word]? = nil
    var categories: [Category]? = nil
    var wordsCategories: [WordCategory]? = nil

    public static func getInstance() -> DataProvider {
        if instance == nil {
            instance = DataProvider()
        }
        return instance!
    }

    public func getWords() -> [Word] {
        if words == nil {
            loadData()
        }
        return words!
    }

    public func getCategories() -> [Category] {
        if categories == nil {
            loadData()
        }
        return categories!
    }

    public func getWordsCategories() -> [WordCategory] {
        if wordsCategories == nil {
            loadData()
        }
        return wordsCategories!
    }

    private func loadData() {
        words = [Word]()
        categories = [Category]()
        wordsCategories = [WordCategory]()

        if NSProcessInfo.processInfo().environment["XCTestConfigurationFilePath"] != nil {
            loadTestData()
        } else {
            requestData()
        }
    }

    private func requestData() {
        let url = NSURL(string: DataProvider.HOST + "export/export.json")
        let request = NSMutableURLRequest(URL: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(LoginHelper.getInstance().authorisationToken, forHTTPHeaderField: "AUTHORIZATION")

        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
                return;
            }
            let responseBody = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let JSONData = responseBody!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            let jsonDictionary = try! NSJSONSerialization.JSONObjectWithData(JSONData!, options: []) as! NSDictionary

            self.words = [Word]()
            if (jsonDictionary["words"] != nil) {
                let words_json = jsonDictionary["words"] as! NSArray;
                for word_dictionary in words_json {
                    self.words!.append(Word(dictionary: word_dictionary as! NSDictionary))
                }
            }
            if (jsonDictionary["categories"] != nil) {
                self.categories = [Category]()
                let categories_json = jsonDictionary["categories"] as! NSArray;
                for category_dictionary in categories_json {
                    self.categories!.append(Category(dictionary: category_dictionary as! NSDictionary))
                }
            }
            if self.serviceResponse != nil {
                self.serviceResponse!()
            }
        }

        task.resume()
    }

    private func loadTestData() {
        words!.append(Word(id: 1, text: "Zapfel", translation: Word(id: 2, text: "шишка")))
        words!.append(Word(id: 3, text: "Hund", translation: Word(id: 4, text: "собака")))
        words!.append(Word(id: 5, text: "Fenster", translation: Word(id: 6, text: "окно")))
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

        categories!.append(Category(id: 1, name: "Haus"))
        categories!.append(Category(id: 2, name: "Tiere"))
        categories!.append(Category(id: 3, name: "Herb"))

        wordsCategories!.append(WordCategory(wordId: 1, categoryId: 1))
        wordsCategories!.append(WordCategory(wordId: 17, categoryId: 1))
        wordsCategories!.append(WordCategory(wordId: 19, categoryId: 1))
        wordsCategories!.append(WordCategory(wordId: 21, categoryId: 1))
        wordsCategories!.append(WordCategory(wordId: 3, categoryId: 2))
        wordsCategories!.append(WordCategory(wordId: 25, categoryId: 2))
        wordsCategories!.append(WordCategory(wordId: 1, categoryId: 3))
        wordsCategories!.append(WordCategory(wordId: 23, categoryId: 3))
    }
}
