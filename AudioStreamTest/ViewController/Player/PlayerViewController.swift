//
//  ViewController.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 10/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class PlayerViewController: AVPlayerViewController, AVPlayerItemMetadataOutputPushDelegate {
    
    var audioPlayer: AVPlayer?
    var playerItem: AVPlayerItem?
    
    var item: RadioItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRemoteTransportControls()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let stream = self.item?.streamURL, let url = URL(string: stream.rawValue) else {
            fatalError("=========== Can`t play stream ===========")
        }
        
        self.playerItem = AVPlayerItem(url: url)
        self.audioPlayer = AVPlayer(playerItem: playerItem)
        self.audioPlayer?.play()
        
        self.player = self.audioPlayer
        self.showsPlaybackControls = true
        
        if let posterImage = self.item?.imageName {
            
            let poster = UIImageView(image: UIImage(named: posterImage))
            poster.frame = self.view.bounds
            poster.contentMode = .scaleAspectFill
            self.contentOverlayView?.addSubview(poster)
        }
        
        let metadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
        metadataOutput.setDelegate(self, queue: .main)
        self.playerItem?.add(metadataOutput)        
    }
    
    // MARK: - AVPlayerItemMetadataOutputPushDelegate
    
    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {
        
        guard let item = groups.first?.items.first else {
            return
        }
        
        print("\(item.value(forKeyPath: "value"))\n\n")
        print(groups)
    }
    
    // MARK: - Reconnect player
    
    public func disconnectAVPlayer() {
        self.player = nil
    }

    public func reconnectAVPlayer() {
        self.player = self.audioPlayer
    }
    
    func setupRemoteTransportControls() {

        guard let player = self.player else {
            return
        }
        
        let commandCenter = MPRemoteCommandCenter.shared()

        commandCenter.playCommand.addTarget { event in
            if player.rate == 0.0 {
                player.play()
                return .success
            }
            
            return .commandFailed
        }

        commandCenter.pauseCommand.addTarget { event in
            
            if player.rate == 1.0 {
                player.pause()
                return .success
            }
            
            return .commandFailed
        }
    }
}

