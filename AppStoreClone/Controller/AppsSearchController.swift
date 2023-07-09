//
//  AppsSearchController.swift
//  AppStoreClone
//
//  Created by Ben Lee on 7/6/23.
//

import UIKit

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "id1234"
    fileprivate var appResults = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: cellId)
        fetchITunesApps()
    }
    
    fileprivate func fetchITunesApps() {
        
        Service.shared.fetchApps { results, error in
            if let error = error {
                print("Failed to fetch iTunes apps, ", error)
                return
            }
            print("Finished fetching apps from controller")
            self.appResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultsCell
        
        let appResult =  appResults[indexPath.item]
        
        cell.nameLabel.text = appResult.trackName
        cell.categoryLabel.text = appResult.primaryGenreName
        
        var rating = appResult.averageUserRating ?? 0
        let roundedRating = (rating * 10).rounded() / 10

        cell.ratingsLabel.text = "Rating: \(roundedRating)"

        return cell
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
