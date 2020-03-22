//
//  RemoteControlManager.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 22/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import Foundation
import MediaPlayer

protocol RemoteControlDelegate {
    func set(action: PlayerControlView.Action)
}

struct RemoteControlManager {
    
    // MARK: - Widget on closed screen

    static func setupRemoteTransportControls(delegate: RemoteControlDelegate?) {
        
        let remoteCommandCenter = MPRemoteCommandCenter.shared()
        let player = PlayerManager.shared.audioPlayer
        
        remoteCommandCenter.nextTrackCommand.isEnabled = true
        remoteCommandCenter.previousTrackCommand.isEnabled = true
        
        remoteCommandCenter.nextTrackCommand.addTarget { (event) in
            delegate?.set(action: .forward)
            return .success
        }
        
        remoteCommandCenter.previousTrackCommand.addTarget { (event) in
            delegate?.set(action: .backward)
            return .success
        }

        remoteCommandCenter.playCommand.addTarget { event in
            delegate?.set(action: .play)
            return .success
        }

        remoteCommandCenter.pauseCommand.addTarget { event in
            delegate?.set(action: .stop)
            return .success
        }
    }
}
