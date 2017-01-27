//
//  Shortcut.swift
//  ResCUer
//
//  Created by Matthew Barker on 1/26/17.
//  Copyright © 2017 Raymone Radi . All rights reserved.
//

import Foundation

enum ShortcutIdentifier: String {
    case First
    case Second
    case Third
    case Fourth
    
    // MARK: Initializers
    
    init?(fullType: String) {
        guard let last = fullType.componentsSeparatedByString(".").last else { return nil }
        
        self.init(rawValue: last)
    }
    
    // MARK: Properties
    
    var type: String {
        return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
    }
}

/// Saved shortcut item used as a result of an app launch, used later when app is activated.
var launchedShortcutItem: UIApplicationShortcutItem?
