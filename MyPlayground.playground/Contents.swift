import UIKit

struct User: Codable {
    let name: String?
}
struct User: Codable {
    let name: String?
}
struct User: Codable {
    let name: String?
}

let jsondata = """
[{"word":"pristine","phonetic":"/pɹɪsˈtaɪn/","phonetics":[{"text":"/pɹɪsˈtaɪn/","audio":"https://api.dictionaryapi.dev/media/pronunciations/en/pristine-1-us.mp3","sourceUrl":"https://commons.wikimedia.org/w/index.php?curid=1755196","license":{"name":"BY-SA 3.0","url":"https://creativecommons.org/licenses/by-sa/3.0"}}],"meanings":[{"partOfSpeech":"adjective","definitions":[{"definition":"Unspoiled; still with its original purity; uncorrupted or unsullied.","synonyms":[],"antonyms":[]},{"definition":"Primitive, pertaining to the earliest state of something.","synonyms":[],"antonyms":[]},{"definition":"Perfect.","synonyms":[],"antonyms":[]}],"synonyms":[],"antonyms":[]}],"license":{"name":"CC BY-SA 3.0","url":"https://creativecommons.org/licenses/by-sa/3.0"},"sourceUrls":["https://en.wiktionary.org/wiki/pristine"]},{"word":"pristine","phonetics":[],"meanings":[{"partOfSpeech":"adjective","definitions":[{"definition":"Relating to sawfishes of the family Pristidae.","synonyms":[],"antonyms":[]}],"synonyms":[],"antonyms":[]}],"license":{"name":"CC BY-SA 3.0","url":"https://creativecommons.org/licenses/by-sa/3.0"},"sourceUrls":["https://en.wiktionary.org/wiki/pristine"]}]
""".data(using: .utf8)

//struct Word: Codable {
//    let word: String
//    let phonetics: [String]
//    let meanings: [Meaning]
//    let license: License
//    let sourceUrls: [String]
//}
//
//struct Meaning: Codable {
//    let partOfSpeech: String
//    let definitions: [Definition]
//    let synonyms: [String]
//    let antonyms: [String]
//}
//
//struct Definition: Codable {
//    let definition: String
//    let synonyms: [String]
//    let antonyms: [String]
//}
//
//struct License: Codable {
//    let name: String
//    let url: String
//}

struct Wordbook: Decodable {
    var word: String?
    var phonetic: String?
    var phonetics: [Phonetic]
    var meanings: [Meaning] = []
    var license: License
    var sourceUrls: [String] = []
           
   struct Phonetic: Decodable {
       var text: String
       var audio: String
       var sourceUrl: String
       var license: License
   }

    struct Meaning: Decodable {
        var partOfSpeech: String
        var definitions: [Definition] = []
        var synonyms: [String] = []
        var antonyms: [String] = []
    }

    struct Definition: Decodable {
        var definition: String
        var synonyms: [String] = []
        var antonyms: [String] = []
    }

    struct License: Decodable {
        var name: String
        var url: String
    }
}

let decoder = JSONDecoder()

do {
    let words = try decoder.decode([Wordbook].self, from: jsondata!)
    print(words[0].word)
} catch {
    print(error)
}
//var greeting = "Hello, playground"
//
//let jsonData = """
//[{
//    "name": "John Doe",
//    "age": 32,
//    "isMarried": true
//}]
//""".data(using: .utf8)!
////
//struct Person: Codable {
//    let name: String
//    let age: Int
//    let isMarried: Bool
//}


//
//let decoder = JSONDecoder()
//
//do {
//    let person = try decoder.decode(Person.self, from: jsonData)
//    print(person.name)  // prints "John Doe"
//} catch {
//    print(error)
//}

//struct Phonetic {
//    let text: String
//    let audio: String
//}
//
//struct Meaning {
//    let partOfSpeech: String
//    let definitions: [
//        let
//    ]
//}
//class RequestHelper {
//    static let shared = RequestHelper()
////    var task = URLSessionDataTask?
//
//    func makeGetRequest(url: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
//        let session = URLSession.shared
//        let url = URL(string: url)!
//
//        let task = session.dataTask(with: url) { data, response, error in
//            if error == nil{
//                let httpResponse = response as! HTTPURLResponse
//                if(httpResponse.statusCode == 200){
//
//
////                    let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//                    typealias ArrayOfDictionary = [[String: [String: Any?]]]
//                    let result = jsonData as! ArrayOfDictionary
//                    print(result)
//
//                    let keys = result
////                    let values = result.values
//
//                    print("keys\n-------")
//                    for key in keys {
//                       print("\(key)")
//                    }
////
////                    print(keys)
////                    print(values)
//                }
//            }
//
////            print(response as Any)
////            if let data = data {
////                let responseString = String(data: data, encoding: .utf8) ?? "{}"
////                print(responseString.data(using: .utf8)!)
////                print(data.count)
////
////            } else {
////                print(error as Any)
////            }
//
////            completion(data, response, error)
//        }
//
//        task.resume()
//
//
//    }
//}
//
//RequestHelper.shared.makeGetRequest(url: "https://api.dictionaryapi.dev/api/v2/entries/en/pristine") {data,response,err in
//    print(data as Any)
//    print(response as Any)
//    print(err as Any)
//}
//
//struct Vocabulary : Decodable {
//    let word: String
//    let phonetic: String
//}
//
//
//struct Vocabularies: [Codable Vocabulary]


let data = """
{"word":"pristine","phonetic":"/pɹɪsˈtaɪn/","phonetics":[{"text":"/pɹɪsˈtaɪn/","audio":"https://api.dictionaryapi.dev/media/pronunciations/en/pristine-1-us.mp3","sourceUrl":"https://commons.wikimedia.org/w/index.php?curid=1755196","license":{"name":"BY-SA 3.0","url":"https://creativecommons.org/licenses/by-sa/3.0"}}],"meanings":[{"partOfSpeech":"adjective","definitions":[{"definition":"Unspoiled; still with its original purity; uncorrupted or unsullied.","synonyms":[],"antonyms":[]},{"definition":"Primitive, pertaining to the earliest state of something.","synonyms":[],"antonyms":[]},{"definition":"Perfect.","synonyms":[],"antonyms":[]}],"synonyms":[],"antonyms":[]}],"license":{"name":"CC BY-SA 3.0","url":"https://creativecommons.org/licenses/by-sa/3.0"},"sourceUrls":["https://en.wiktionary.org/wiki/pristine"]}
""".data(using: .utf8)

enum IntOrString: Decodable {

    case int(Int)
    case string(String)

    init(from decoder: Decoder) throws {

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }

        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }

        throw IntOrStringError.intOrStringNotFound
    }

    enum IntOrStringError: Error {
        case intOrStringNotFound
    }
}

struct Response: Decodable {
    var values: [[IntOrString]]
}

if let response = try? JSONDecoder().decode(Response.self, from: data!) {
    let values = response.values

    for value in values {
        for intOrString in value {
            switch intOrString {
            case .int(let int): print("It's an int: \(int)")
            case .string(let string): print("It's a string: \(string)")
            }
        }
    }
}
