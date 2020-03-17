//
//  AppStoryboardBridge.swift
//  Storyboard Instanse
//
//  Created by Sergey Krasiuk on 12.11.16.
//  Copyright © 2016 Sergey Krasiuk. All rights reserved.
//

import UIKit

enum StoryboardManager: String {
    
    // MARK: Storyboards names
    
    case main
    
    var storyboardInstance : UIStoryboard {
        return UIStoryboard(name: self.rawValue.capitalized, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardId
        return storyboardInstance.instantiateViewController(withIdentifier: storyboardId) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return storyboardInstance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    class var storyboardId: String {
        return "\(self)"
    }
    
    static func instantiateFrom(storyboard: StoryboardManager) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
}
