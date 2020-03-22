//
//  PlayerManager.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 19/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import AVKit

class PlayerManager {
    
    static let shared = PlayerManager()
    var audioPlayer: AVPlayer?
    var playerItem: AVPlayerItem?
    
    private init() {}
    
    // MARK: - Private
        
    // MARK: - Player
    
    func play(stream item: RadioItem?, controller: UIViewController?) {
        
        guard let stream = item?.streamURL, let url = URL(string: stream.rawValue) else {
            fatalError("=========== Can`t play stream ===========")
        }
        
        self.audioPlayer?.stop()
        self.playerItem = AVPlayerItem(url: url)
        self.audioPlayer = AVPlayer(playerItem: playerItem)
        self.audioPlayer?.play()
        
        if let delegateController = controller {
            let metadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
            metadataOutput.setDelegate(delegateController as? AVPlayerItemMetadataOutputPushDelegate, queue: .main)
            self.playerItem?.add(metadataOutput)
        }
    }
}
