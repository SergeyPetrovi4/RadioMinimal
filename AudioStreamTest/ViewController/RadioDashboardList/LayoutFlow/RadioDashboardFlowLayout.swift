//
//  RadioDashboardLobbyFlowLayout.swift
//  Meuhedet
//
//  Created by Sergey Krasiuk on 28/05/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import Foundation
import UIKit

class RadioDashboardFlowLayout: UICollectionViewFlowLayout {
    
    enum LayoutType {
        case galery
        case list
    }
    
    var layoutType: LayoutType = .galery
    private let padding: CGFloat = 10.0
    
    override init() {
        super.init()
        
        self.setupCustomFlowLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupCustomFlowLayout()
    }
    
    func setupCustomFlowLayout() {
        
        self.minimumInteritemSpacing = self.padding
        self.minimumLineSpacing = self.padding
        self.scrollDirection = .vertical
    }
    
    override var itemSize: CGSize {
        
        set {}
        
        get {
            
            switch self.layoutType {
                
            case .galery:
                
                let numberOfColumns: CGFloat = 2.0
                let itemWidth = (self.collectionView!.frame.width - (self.padding * 2) - ((numberOfColumns - 1) * self.minimumInteritemSpacing)) / numberOfColumns
                return CGSize(width: itemWidth, height: itemWidth * 1.3)
                
            case .list:
                
                let numberOfColumns: CGFloat = 1.0
                let itemWidth = (self.collectionView!.frame.width - (self.padding * 2) - (numberOfColumns - 1)) / numberOfColumns
                
                return CGSize(width: itemWidth, height: 68)
            }
            
        }
    }
    
    override var sectionInset: UIEdgeInsets {
        
        set {}
        
        get {
            return UIEdgeInsets(top: self.padding, left: self.padding, bottom: self.padding, right: self.padding)
        }
    }
}
