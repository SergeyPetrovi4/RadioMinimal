//
//  PlayerControlView.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 19/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import UIKit
import QuartzCore

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
        instance.streamTitleLabel.type = .leftRight
        instance.posterImageView.image = UIImage(named: "emptyPoster")
        
        NSLayoutConstraint.activate([
            instance.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            instance.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            instance.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        view.bringSubviewToFront(instance)
        
        instance.posterImageView.layer.cornerRadius = 10.0
        instance.posterContainerView.layer.cornerRadius = 10.0
        instance.posterContainerView.layer.shadowRadius = 4.0
        instance.posterContainerView.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        instance.posterContainerView.layer.shadowColor = UIColor.black.cgColor
        instance.posterContainerView.layer.shadowOpacity = 0.3
        instance.posterContainerView.layer.shouldRasterize = true
        
        return instance
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var posterContainerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var streamTitleLabel: MarqueeLabel!
    
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
        
        self.streamTitleLabel.text = " "
        
        if action == .play {
            self.streamTitleLabel.text = "Loading... Please wait... Loading... Please wait..."
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
