//
//  RadioDashboardListViewController.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 13/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import UIKit

class RadioDashboardListViewController: UIViewController, RadioDashboardListViewProtocol  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var presenter: RadioDashboardListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = RadioDashboardListPresenter(for: self)
        self.setupCollectionView()
    }
    
    // MARK: - UI
    
    private func setupCollectionView() {
        
        let layout = RadioDashboardFlowLayout()
        layout.layoutType = .list
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: String(describing: RadioItemCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: RadioItemCollectionViewCell.self))
    }
    
    // MARK: - Actions
    
    // MARK: - Private
    
    // MARK: - RadioDashboardListViewProtocol
}

extension RadioDashboardListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RadioItemCollectionViewCell.self), for: indexPath) as! RadioItemCollectionViewCell
        cell.configure(with: self.presenter.items[indexPath.item])
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let playerController = PlayerViewController.instantiateFrom(storyboard: .main)
        playerController.item = self.presenter.items[indexPath.item]
        self.present(playerController, animated: true, completion: nil)
    }
}

extension RadioDashboardListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard let layout = collectionView.collectionViewLayout as? RadioDashboardFlowLayout else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        return layout.sectionInset
    }
}
