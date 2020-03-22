//
//  RadioDashboardListViewController.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 13/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import UIKit
import AVKit

class RadioDashboardListViewController: UITableViewController, RadioDashboardListViewProtocol, AVPlayerItemMetadataOutputPushDelegate {
        
    private var presenter: RadioDashboardListPresenterProtocol!
    private var playerControlView: PlayerControlView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = RadioDashboardListPresenter(for: self)
        
        self.playerControlView = PlayerControlView.instanceFromNib(for: self.view) { (action) in
            self.controlView(action: action)
        }
            
        
        self.setupTableView()
        self.presenter.set(remoteCenterDelegate: self)
    }
    
    // MARK: - UI / Private
    
    private func setupTableView() {

        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.playerControlView.frame.height + self.view.safeAreaInsets.bottom, right: 0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.register(UINib(nibName: String(describing: RadioItemViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RadioItemViewCell.self))
    }
    
    
    // MARK: - Private
    
    private func select(itemAtIndexPath indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
    }
    
    private func controlView(action: PlayerControlView.Action) {
        
        switch action {
                
            case .play:
                
                // Play first stream from array of items if app first time run
                
                if PlayerManager.shared.audioPlayer == nil {
                    
                    PlayerManager.shared.play(stream: self.presenter.items.first, controller: self)
                    self.playerControlView.configure(image: self.presenter.items.first!.imageName)
                    self.playerControlView.set(action: .play)
                    self.select(itemAtIndexPath: IndexPath(row: 0, section: 0))
                    return
                }
                
                // Continue playing after stopping
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    
                    PlayerManager.shared.play(stream: self.presenter.items[indexPath.row], controller: self)
                    self.playerControlView.configure(image: self.presenter.items[indexPath.row].imageName)
                    self.playerControlView.set(action: .play)
                    self.select(itemAtIndexPath: indexPath)
                }
                
            case .forward:
                                
                if let indexPath = self.tableView.indexPathForSelectedRow, indexPath.row < self.presenter.items.count - 1 {
                                    
                    PlayerManager.shared.play(stream: self.presenter.items[indexPath.row + 1], controller: self)
                    self.playerControlView.configure(image: self.presenter.items[indexPath.row + 1].imageName)
                    self.playerControlView.set(action: .play)
                    self.select(itemAtIndexPath: IndexPath(item: indexPath.row + 1, section: 0))
                }
                
            case .backward:
                                
                if let indexPath = self.tableView.indexPathForSelectedRow, indexPath.item > 0 {
                                    
                    PlayerManager.shared.play(stream: self.presenter.items[indexPath.row - 1], controller: self)
                    self.playerControlView.configure(image: self.presenter.items[indexPath.row - 1].imageName)
                    self.playerControlView.set(action: .play)
                    self.select(itemAtIndexPath: IndexPath(item: indexPath.item - 1, section: 0))
                }
                
            case .stop:
                
                PlayerManager.shared.audioPlayer?.stop()
                self.playerControlView.set(action: .stop)
            }
    }
        
    // MARK: - RadioDashboardListViewProtocol

    // MARK: - RemoteControlDelegate
    
    func set(action: PlayerControlView.Action) {
        self.controlView(action: action)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        PlayerManager.shared.play(stream: self.presenter.items[indexPath.row], controller: self)
        self.playerControlView.configure(image: self.presenter.items[indexPath.row].imageName)
        self.playerControlView.set(action: .play)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RadioItemViewCell.self), for: indexPath) as! RadioItemViewCell
        cell.configure(with: self.presenter.items[indexPath.row])
        return cell
    }
    
    //MARK: - AVPlayerItemMetadataOutputPushDelegate

    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {

        guard let item = groups.first?.items.first, let title = item.value(forKeyPath: "value") as? String else {
            self.playerControlView.streamTitleLabel.text = " "
            return
        }

        self.playerControlView.streamTitleLabel.text = title
    }
}
