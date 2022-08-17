//
//  Extension.swift
//  noteApp
//
//  Created by Konstantin on 26.09.2021.
//

import Foundation
import UIKit

extension UserDefaults {
    var isFirstLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isFirstLaunch")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isFirstLaunch")
        }
    }
}
