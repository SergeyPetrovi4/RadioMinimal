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
        
        self.posterImageView.layer.cornerRadius = 10.0
    }
    
    // MARK: - Configurable
    
    func configure(with item: RadioItem) {
        self.posterImageView.image = UIImage(named: item.imageName)
        self.streamTitleLabel.text = item.title
    }
}
