//
//  Notification+Name.swift
//  Core
//
//  Created by Ian on 12/3/23.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import Foundation

extension Notification.Name {
    public enum SOPT {
        public static let willEnterForeground = Notification.Name(rawValue: "sopt.willenterforeground")
        public static let willEnterBackground = Notification.Name(rawValue: "sopt.willbackforeground")
    }
}
