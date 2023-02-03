//
//  DataStructure.swift
//  vocabook
//
//  Created by Karl Lim on 1/29/23.
//

import Foundation

class NCUser: NSObject {
    var id: String?
    var name: String?
    
    class var isLoggedIn: Bool {
        return true
    }
}

struct Word {
    var name: String
    var description: String
    var phonetic: String?
}

//struct Word {
//    var word: String?
//    var meanings: [Meaning] = []
//    var phonetic: String?
//}

struct Wordbook: Decodable {
    var word: String?
    var phonetic: String?
    var phonetics: [Phonetic]
    var meanings: [Meaning] = []
    var license: License?
    var sourceUrls: [String] = []
}

struct Phonetic: Decodable {
    var text: String?
    var audio: String?
    var sourceUrl: String?
    var license: License?
}

struct Meaning: Decodable {
    var partOfSpeech: String?
    var definitions: [Definition] = []
    var synonyms: [String] = []
    var antonyms: [String] = []
}

struct Definition: Decodable {
    var definition: String?
    var synonyms: [String] = []
    var antonyms: [String] = []
}

struct License: Decodable {
    var name: String?
    var url: String?
}
