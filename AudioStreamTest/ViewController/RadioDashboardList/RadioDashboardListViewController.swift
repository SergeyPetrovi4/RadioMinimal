//
//  RadioDashboardListViewController.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 13/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import UIKit
import AVKit

class RadioDashboardListViewController: UIViewController, RadioDashboardListViewProtocol  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var presenter: RadioDashboardListPresenterProtocol!
    private var playerControlView: PlayerControlView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = RadioDashboardListPresenter(for: self)
        
        self.playerControlView = PlayerControlView.instanceFromNib(for: self.view) { (action) in
            
            switch action {
                
            case .play:
                
                // Play first stream from array of items if app first time run
                
                if PlayerManager.shared.audioPlayer == nil {
                    
                    PlayerManager.shared.play(stream: self.presenter.items.first, controller: self)
                    self.playerControlView.configure(image: self.presenter.items.first!.imageName)
                    self.playerControlView.set(action: .play)
                    self.select(itemAtIndexPath: IndexPath(item: 0, section: 0))
                    return
                }
                
                // Continue playing after stopping
                
                if let indexPath = self.collectionView.indexPathsForSelectedItems?.first {
                    
                    PlayerManager.shared.play(stream: self.presenter.items[indexPath.item], controller: self)
                    self.playerControlView.configure(image: self.presenter.items[indexPath.item].imageName)
                    self.playerControlView.set(action: .play)
                    self.select(itemAtIndexPath: indexPath)
                }
                
            case .forward:
                                
                if let indexPath = self.collectionView.indexPathsForSelectedItems?.first, indexPath.item < self.presenter.items.count - 1 {
                                    
                    PlayerManager.shared.play(stream: self.presenter.items[indexPath.item + 1], controller: self)
                    self.playerControlView.configure(image: self.presenter.items[indexPath.item + 1].imageName)
                    self.playerControlView.set(action: .play)
                    self.select(itemAtIndexPath: IndexPath(item: indexPath.item + 1, section: 0))
                }
                
            case .backward:
                                
                if let indexPath = self.collectionView.indexPathsForSelectedItems?.first, indexPath.item > 0 {
                                    
                    PlayerManager.shared.play(stream: self.presenter.items[indexPath.item - 1], controller: self)
                    self.playerControlView.configure(image: self.presenter.items[indexPath.item - 1].imageName)
                    self.playerControlView.set(action: .play)
                    self.select(itemAtIndexPath: IndexPath(item: indexPath.item - 1, section: 0))
                }
                
            case .stop:
                
                PlayerManager.shared.audioPlayer?.stop()
                self.playerControlView.set(action: .stop)
            }
        }
        
        self.setupCollectionView()
    }
    
    // MARK: - UI
    
    private func setupCollectionView() {
        
        let layout = RadioDashboardFlowLayout()
        layout.layoutType = .list
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.playerControlView.frame.height + self.view.safeAreaInsets.bottom, right: 0)
        
        self.collectionView.register(UINib(nibName: String(describing: RadioItemCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: RadioItemCollectionViewCell.self))
    }
    
    
    // MARK: - Private
    
    private func select(itemAtIndexPath indexPath: IndexPath) {
        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
    }
    
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
        
        PlayerManager.shared.play(stream: self.presenter.items[indexPath.item], controller: self)
        self.playerControlView.configure(image: self.presenter.items[indexPath.item].imageName)
        self.playerControlView.set(action: .play)
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

extension RadioDashboardListViewController: AVPlayerItemMetadataOutputPushDelegate {
    
    //MARK: - AVPlayerItemMetadataOutputPushDelegate

    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {

        guard let item = groups.first?.items.first, let title = item.value(forKeyPath: "value") as? String else {
            return
        }

        self.playerControlView.streamTitleLabel.text = title
    }
}
