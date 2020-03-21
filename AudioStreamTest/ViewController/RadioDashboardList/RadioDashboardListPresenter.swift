//
//  RadioDashboardListPresenter.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 13/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import Foundation
import AVKit

class RadioDashboardListPresenter: RadioDashboardListPresenterProtocol {
    
    weak var view: RadioDashboardListViewProtocol?
    
    init(`for` view: RadioDashboardListViewProtocol) {
        self.view = view
    }
    
    // MARK: - Private
    
    // MARK: - RadioDashboardListPresenterProtocol
    
    var items: [RadioItem] = {
        return RadioItems.values
    }()
    
    func play(itemAt index: Int, controller: UIViewController?) {
        PlayerManager.shared.play(stream: self.items[index], controller: controller)
    }
}
