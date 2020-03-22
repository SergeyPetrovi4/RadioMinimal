//
//  RadioDashboardListContract.swift
//  AudioStreamTest
//
//  Created by Sergey Krasiuk on 13/03/2020.
//  Copyright © 2020 Sergey Krasiuk. All rights reserved.
//

import Foundation
import UIKit

protocol RadioDashboardListViewProtocol: class, RemoteControlDelegate {
    
}

protocol RadioDashboardListPresenterProtocol {
    
    var items: [RadioItem] { get }
    func set(remoteCenterDelegate controller: UIViewController?)
}
