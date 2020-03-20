//
//  PlayerManager.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 19/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import AVKit
import MediaPlayer

class PlayerManager {
    
    static let shared = PlayerManager()
    var audioPlayer: AVPlayer?
    var playerItem: AVPlayerItem?
    
    private init() {}
    
    // MARK: - Private
    
    private var remoteCommandCenter: MPRemoteCommandCenter?
    
    // MARK: - Player
    
    func play(stream item: RadioItem?, controller: UIViewController?) {
        
        guard let stream = item?.streamURL, let url = URL(string: stream.rawValue) else {
            fatalError("=========== Can`t play stream ===========")
        }
        
        self.audioPlayer?.stop()
        self.playerItem = AVPlayerItem(url: url)
        self.audioPlayer = AVPlayer(playerItem: playerItem)
        self.audioPlayer?.play()
        
        if self.remoteCommandCenter == nil {
            self.setupRemoteTransportControls()
        }
        
        if let delegateController = controller {
            let metadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
            metadataOutput.setDelegate(delegateController as? AVPlayerItemMetadataOutputPushDelegate, queue: .main)
            self.playerItem?.add(metadataOutput)
        }
    }
    
    // MARK: - Widget on closed screen

    func setupRemoteTransportControls() {
        
        if self.remoteCommandCenter != nil { return }
    
        guard let player = self.audioPlayer else {
            return
        }

        self.remoteCommandCenter = MPRemoteCommandCenter.shared()

        self.remoteCommandCenter?.playCommand.addTarget { event in
            if player.rate == 0.0 {
                player.play()
                return .success
            }

            return .commandFailed
        }

        self.remoteCommandCenter?.pauseCommand.addTarget { event in

            if player.rate == 1.0 {
                player.pause()
                return .success
            }

            return .commandFailed
        }
    }
}

    // MARK: - AVPlayerItemMetadataOutputPushDelegate

//extension PlayerManager: AVPlayerItemMetadataOutputPushDelegate {
//    
//    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {
//        
//        guard let item = groups.first?.items.first else {
//            return
//        }
//        
//        print("\(item.value(forKeyPath: "value"))\n\n")
//        print(groups)
//    }
//}
