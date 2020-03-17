//
//  RadioItemCollectionViewCell.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 13/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import UIKit

class RadioItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: ShadowedView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var streamTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.setRoundedCorners(radius: 10.0)
        
        streamTitleLabel.layer.shadowColor = UIColor.black.cgColor
        streamTitleLabel.layer.shadowRadius = 4.0
        streamTitleLabel.layer.shadowOpacity = 1.0
        streamTitleLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        streamTitleLabel.layer.masksToBounds = false
    }
    
    // MARK: - Configurable
    
    func configure(with item: RadioItem) {
        self.posterImageView.image = UIImage(named: item.imageName)
        self.streamTitleLabel.text = item.title
    }
}
