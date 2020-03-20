//
//  PlayerControlView.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 19/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import UIKit

typealias ActionHandler = ((_ action: PlayerControlView.Action) -> Void)

class PlayerControlView: UIView {
    
    enum Action {
        case play
        case forward
        case backward
        case stop
    }
    
    @IBOutlet weak var playButton: UIButton!
    
    class func instanceFromNib(for view: UIView, completion: @escaping ActionHandler) -> PlayerControlView {
        
        let instance = UINib(nibName: String(describing: PlayerControlView.self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PlayerControlView
        
        view.addSubview(instance)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.clipsToBounds = true
        instance.completion = completion
        instance.streamTitleLabel.text = " "
        instance.posterImageView.image = UIImage(named: "emptyPoster")
        
        NSLayoutConstraint.activate([
            instance.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            instance.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            instance.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        view.bringSubviewToFront(instance)
        
        return instance
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var streamTitleLabel: UILabel!
    
    private var completion: ActionHandler!
    private var playState = Action.play
    
    // MARK: - Actions
    
    @IBAction func didTapForwardButton(_ sender: UIButton) {
        self.completion(.forward)
    }
    
    @IBAction func didTapBackwardButton(_ sender: UIButton) {
        self.completion(.backward)
    }
    
    @IBAction func didTapPlayButton(_ sender: UIButton) {
        
        self.completion(self.playState)
    }
    
    // MARK: - Methods
    
    func set(action: Action) {
        
        if action == .play {
            self.playButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            self.playState = .stop
            return
        }

        if action == .stop {
            self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            PlayerManager.shared.audioPlayer?.stop()
            self.playState = .play
            self.streamTitleLabel.text = " "
            self.posterImageView.image = UIImage(named: "emptyPoster")
        }
    }
    
    func configure(image name: String) {
        self.posterImageView.image = UIImage(named: name)
    }
}
