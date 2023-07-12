//
//  AppsController.swift
//  AppStoreClone
//
//  Created by Ben Lee on 7/10/23.
//

import Foundation
import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let headerID = "header id"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupsCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        fetchTopFreeApps()
    }
    
    fileprivate func fetchTopFreeApps() {
        Service.shared.fetchTopFreeApps { appGroup, error in
            if let error = error {
                print("Failed to fetch top free apps", error)
                return
            }
            self.topFreeApps = appGroup
            if let group = appGroup {
                self.groups.append(group)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        Service.shared.fetchTopPaidApps { appGroup, error in
            if let error = error {
                print("Failed to fetch top paid apps", error)
                return
            }
            self.topFreeApps = appGroup
            if let group = appGroup {
                self.groups.append(group)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
        
        return header
    }
    
    var topFreeApps: AppGroup?
    var groups: [AppGroup] = []
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! AppsGroupsCell
        
        let appGroup = groups[indexPath.item]
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        cell.horizontalController.collectionView.reloadData()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }

}
