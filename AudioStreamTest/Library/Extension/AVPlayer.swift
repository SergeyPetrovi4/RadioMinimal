//
//  AVPlayer.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 19/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import Foundation
import AVFoundation

extension AVPlayer {
    
    func stop() {
        self.seek(to: CMTime.zero)
        self.pause()
    }
}
