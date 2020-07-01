//
//  ArticleManager.swift
//  TableView
//
//  Created by Bogdan on 1/7/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import Foundation

class NewsNetworkManager {
    // MARK: Variables
    static let shared = NewsNetworkManager()
    private let baseURL = "https://newsapi.org/v2/everything"
    
    //All articles mentioning Apple from yesterday, sorted by popular publishers first
    func getAppleArticles(completion: @escaping (Result<[Article], NError>) -> Void) {
        
        //Date today
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: date)
        
        let parameters = [
            "q" : "apple",
            "from" : today,
            "to" : today,
            "language" : "en",
            "sortBy" : "popularity",
            "pageSize" : "20",
            "apiKey" : Secrets.NEWS_API
            ]
        
        RESTful.request(path: baseURL, method: "GET", parameters: parameters, headers: nil) { result in
            
            switch result {
            case .success(let data):

                do{
                    let decoder = JSONDecoder()
                    
                    //START - add date formatting to the decoder
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    dateFormatter.locale = Locale(identifier: "en_AU")
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    //END
                    
                    let news: NewsRoot = try decoder.decode(NewsRoot.self, from: data)
                    completion(.success(news.articles))
                } catch let error {
                    print(error)
                    completion(.failure(.invalidJson))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
