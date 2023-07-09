//
//  AppsSearchController.swift
//  AppStoreClone
//
//  Created by Ben Lee on 7/6/23.
//

import UIKit
import SDWebImage

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
        
        let rating = appResult.averageUserRating ?? 0
        let roundedRating = (rating * 10).rounded() / 10

        cell.ratingsLabel.text = "Rating: \(roundedRating)"
        
        let url = URL(string: appResult.artworkUrl100)
        cell.appIconImageView.sd_internalSetImage(with: url, placeholderImage: UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill"), context: nil, setImageBlock: nil, progress: nil)
        
        
        cell.screenshot1ImageView.sd_internalSetImage(with: URL(string: appResult.screenshotUrls[0]), placeholderImage: UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill"), context: nil, setImageBlock: nil, progress: nil)
        

        if appResult.screenshotUrls.count > 1 {
            cell.screenshot2ImageView.sd_internalSetImage(with: URL(string: appResult.screenshotUrls[1]), placeholderImage: UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill"), context: nil, setImageBlock: nil, progress: nil)
        }
        
        if appResult.screenshotUrls.count > 2 {
            cell.screenshot3ImageView.sd_internalSetImage(with: URL(string: appResult.screenshotUrls[2]), placeholderImage: UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill"), context: nil, setImageBlock: nil, progress: nil)

        }

        return cell
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
