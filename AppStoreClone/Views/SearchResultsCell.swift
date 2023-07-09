//
//  SearchResultsCell.swift
//  AppStoreClone
//
//  Created by Ben Lee on 7/6/23.
//

import UIKit

class SearchResultsCell: UICollectionViewCell {
    
    var appResult: Result! {
        didSet {
            self.nameLabel.text = appResult.trackName
            self.categoryLabel.text = appResult.primaryGenreName
            
            let rating = appResult.averageUserRating ?? 0
            let roundedRating = (rating * 10).rounded() / 10

            self.ratingsLabel.text = "Rating: \(roundedRating)"
            
            let url = URL(string: appResult.artworkUrl100)
            self.appIconImageView.sd_internalSetImage(with: url, placeholderImage: UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill"), context: nil, setImageBlock: nil, progress: nil)
            
            
            self.screenshot1ImageView.sd_internalSetImage(with: URL(string: appResult.screenshotUrls[0]), placeholderImage: UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill"), context: nil, setImageBlock: nil, progress: nil)
            

            if appResult.screenshotUrls.count > 1 {
                self.screenshot2ImageView.sd_internalSetImage(with: URL(string: appResult.screenshotUrls[1]), placeholderImage: UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill"), context: nil, setImageBlock: nil, progress: nil)
            }
            
            if appResult.screenshotUrls.count > 2 {
                self.screenshot3ImageView.sd_internalSetImage(with: URL(string: appResult.screenshotUrls[2]), placeholderImage: UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill"), context: nil, setImageBlock: nil, progress: nil)

            }
        }
    }
    
    let appIconImageView: UIView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
       return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Video"
       return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.62M"
       return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 16
       return button
    }()
    
    lazy var screenshot1ImageView = self.createScreenshotImageView()
    lazy var screenshot2ImageView = self.createScreenshotImageView()
    lazy var screenshot3ImageView = self.createScreenshotImageView()
    
    func createScreenshotImageView() -> UIImageView {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        iv.contentMode = .scaleToFill
        return iv
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelsStackView: UIStackView = VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        
        let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screenShotsStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView])
        screenShotsStackView.spacing = 12
        screenShotsStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screenShotsStackView], spacing: 16)
        
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
