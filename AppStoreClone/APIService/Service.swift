//
//  Service.swift
//  AppStoreClone
//
//  Created by Ben Lee on 7/8/23.
//

import Foundation

class Service {
    static let shared = Service() // Singleton
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        print("Fetching iTunes Apps from the service layer.")
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print("Error: Failed to fetch apps. \(error.localizedDescription)")

            } else {

                guard let data = data else {return}

                do {
                    let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                    //self.appResults = searchResult.results
//                    DispatchQueue.main.async {
//                        self.collectionView.reloadData()
//                    }
                    completion(searchResult.results, nil)

                } catch let jsonError {
                    print("Error: Failed to decode JSON. \(jsonError.localizedDescription)")
                    completion([], jsonError)

                }

            }

        }.resume()
    }
}
