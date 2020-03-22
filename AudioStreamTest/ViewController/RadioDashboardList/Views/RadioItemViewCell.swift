//
//  RadioItemCollectionViewCell.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 13/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import UIKit

class RadioItemViewCell: UITableViewCell {

    @IBOutlet weak var posterContainerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var streamTitleLabel: UILabel!
    @IBOutlet weak var loaderImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.posterImageView.layer.cornerRadius = 10.0
        self.posterContainerView.layer.cornerRadius = 10.0
        self.posterContainerView.layer.shadowRadius = 4.0
        self.posterContainerView.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.posterContainerView.layer.shadowColor = UIColor.black.cgColor
        self.posterContainerView.layer.shadowOpacity = 0.3
        self.posterContainerView.layer.shouldRasterize = true
        
        self.loaderImageView.isHidden = true
        
        if let gifLoader = UIImage.gifImageWithName("loader") {
            let tintableImage = gifLoader.withRenderingMode(.alwaysTemplate)
            self.loaderImageView.image = tintableImage
            self.loaderImageView.tintColor = .systemBlue
        }
    }
    
    // MARK: - Configurable
    
    func configure(with item: RadioItem) {
        self.posterImageView.image = UIImage(named: item.imageName)
        self.streamTitleLabel.text = item.title
    }
    
    // MARK: - Selection
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.loaderImageView.isHidden = !selected
    }
}
