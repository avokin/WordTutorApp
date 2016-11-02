//
// Created by Andrey Vokin on 10/04/16.
// Copyright (c) 2016 avokin. All rights reserved.
//

import Foundation

open class DataProvider {
    open static let HOST = "http://localhost:3000/"

    static let DATA_FILE_NAME = "data.json"

    fileprivate static var instance: DataProvider? = nil

    open var serviceResponse: (() -> Void)? = nil

    var dictionary = NSMutableDictionary()

    var words: [Word]? = nil
    var categories: [Category]? = nil
    var trainings: [Training]? = nil
    var wordsCategories: [WordCategory]? = nil
    var idsWord: [Int:Word] = [Int:Word]()
    var idsCategory: [Int:Category] = [Int:Category]()

    open static func getInstance() -> DataProvider {
        if instance == nil {
            instance = DataProvider()
        }
        return instance!
    }

    open func getWordsOfDestinationLanguage() -> [Word] {
        // ToDo: filter
        var result = [Word]()
        for word in getWords() {
            if word.getLanguageId() == 3 {
                result.append(word)
            }
        }
        return result
    }

    open func getWords() -> [Word] {
        if words == nil {
            loadData()
        }
        return words!
    }

    open func getCategories() -> [Category] {
        if categories == nil {
            loadData()
        }
        return categories!
    }

    open func getTrainings() -> [Training] {
        if trainings == nil {
            trainings = [Training]()
            let categories = getCategories()
            for category in categories {
                trainings!.append(Training(category: category))
            }
        }
        return trainings!
    }

    open func getWordsCategories() -> [WordCategory] {
        if wordsCategories == nil {
            loadData()
        }
        return wordsCategories!
    }

    fileprivate func loadData() {
        words = [Word]()
        categories = [Category]()
        wordsCategories = [WordCategory]()

        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            loadTestData()
        } else {
            requestData()
        }
    }

    open func readFromFile(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            parseData(data: data)
        }
        catch  {
            print("Error reading data: \(error)")
        }
    }

    open func readFromFile() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let url = dir.appendingPathComponent(DataProvider.DATA_FILE_NAME)
            readFromFile(url: url)
        }
    }

    open func saveToFile() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(DataProvider.DATA_FILE_NAME)

            do {
                let content = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
                try content.write(to: path)
            } catch {
                print("Error writing data: \(error)")
            }
        }
    }

    func parseData(data: Data) {
        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary

        self.words = [Word]()
        if (jsonDictionary["error"] != nil) {
            print(jsonDictionary["error"])
            LoginHelper.getInstance().setAuthorizationToken(nil)
            return
        }
        if (jsonDictionary["words"] != nil) {
            let array = NSMutableArray()
            self.dictionary["words"] = array

            let words_json = jsonDictionary["words"] as! NSArray;
            for word_dictionary in words_json {
                let wordMutableDictionary = NSMutableDictionary(dictionary: word_dictionary as! NSDictionary)
                array.add(wordMutableDictionary)
                self.words!.append(Word(dictionary: wordMutableDictionary))
            }
        }
        if (jsonDictionary["categories"] != nil) {
            self.dictionary["categories"] = jsonDictionary["categories"]
            self.categories = [Category]()
            let categories_json = jsonDictionary["categories"] as! NSArray;
            for category_dictionary in categories_json {
                self.categories!.append(Category(dictionary: category_dictionary as! NSDictionary))
            }
        }

        if (jsonDictionary["word_relations"] != nil) {
            self.dictionary["word_relations"] = jsonDictionary["word_relations"]
            let word_relations_json = jsonDictionary["word_relations"] as! NSArray;
            for word_relation_dictionary in (word_relations_json as? [[String:Any]])! {
                let source_word_id = (word_relation_dictionary["source_user_word_id"] as! NSNumber).intValue
                let related_word_id = (word_relation_dictionary["related_user_word_id"] as! NSNumber).intValue
                let relation_type = (word_relation_dictionary["relation_type"] as! NSNumber).intValue

                let source_word = Word.ids[source_word_id]!
                let related_word = Word.ids[related_word_id]!

                if relation_type == 1 {
                    source_word.translations.append(related_word)
                    related_word.translations.append(source_word)
                } else {
                    source_word.synonyms.append(related_word)
                    related_word.synonyms.append(source_word)
                }
            }
        }

        if (jsonDictionary["word_categories"] != nil) {
            self.dictionary["word_categories"] = jsonDictionary["word_categories"]
            let word_categories = jsonDictionary["word_categories"] as! NSArray;
            for word_category_dictionary in (word_categories as? [[String:Any]])! {
                let user_word_id = (word_category_dictionary["user_word_id"] as! NSNumber).intValue
                let user_category_id = (word_category_dictionary["user_category_id"] as! NSNumber).intValue
                WordCategory.create(user_word_id, categoryId: user_category_id)
            }
        }
    }

    fileprivate func requestData() {
        self.readFromFile()

        let url = URL(string: DataProvider.HOST + "export/export.json")
        let request = NSMutableURLRequest(url: url!)

        let updatedWords = words!.filter{$0.isUpdated()}
        let updatedTexts = updatedWords.map{"{\"id\": \($0.id), \"success_count\": \($0.getSuccessCount()), \"time_to_check\": \"\(JsonParser.getDateFormatter().string(from: $0.getTimeToCheck()))\"}"}
        let updatedText = updatedTexts.joined(separator: ", ")
        let requestBodyText = "{\"updatedWords\": [\(updatedText)]}"

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestBodyText.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        request.setValue(LoginHelper.getInstance().getAuthorizationToken(), forHTTPHeaderField: "AUTHORIZATION")

        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
                return;
            }

            self.parseData(data: data!)

            self.saveToFile()

            if self.serviceResponse != nil {
                self.serviceResponse!()
            }
        }) 

        task.resume()
    }

    fileprivate func loadTestData() {
        var testBundle = Bundle.main
        for bundle in Bundle.allBundles {
            if bundle.bundleIdentifier != nil && bundle.bundleIdentifier!.hasSuffix("Test") {
                testBundle = bundle
            }
        }

        let url = testBundle.url(forResource: "data", withExtension: "json")

        readFromFile(url: url!)
    }
}
