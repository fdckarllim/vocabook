//
//  RequestHelper.swift
//  vocabook
//
//  Created by Karl Lim on 2/1/23.
//

import Foundation

//var task:URLSessionDataTask?

class RequestHelper {
    static let shared = RequestHelper()
    var task: URLSessionDataTask?
    
//    func makeGetRequest(url: String?) {
//        let url = URL(string: url!)!
//
//        self.task?.cancel()
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                let responseString = String(data: data, encoding: .utf8)
//            } else {
//                print(error?.localizedDescription ?? "No data")
//            }
//        }
//        self.task = task
//        task.resume()
//    }
    
    func getWordDetails(word: String, completion:@escaping ([Wordbook], Error?) -> Void){
        let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)")
        
        self.task?.cancel()

        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
//                let responseString = String(data: data, encoding: .utf8)
                let decoder = JSONDecoder()
                do {
                    let words = try decoder.decode([Wordbook].self, from: data)
                    print(words[0].word as Any)
                    completion(words, error)
                } catch {
                    print(error)
                    completion([], error)
                }

            } else {
                print(error?.localizedDescription ?? "No data")
                completion([], error)
            }
        }
        
        
        
        self.task = task
        task.resume()
    }
}


